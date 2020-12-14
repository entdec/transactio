# frozen_string_literal: true

require 'active_support/concern'

module Transactio
  module ActiveRecord
    module TransactionLoggable
      extend ActiveSupport::Concern

      included do
        has_many :transaction_log_entries, as: :transaction_loggable, class_name: 'Transactio::TransactionLogEntry'

        # Only do this if we actually use a state machine
        if respond_to?(:state_machines)
          state_machine.after_transition do |object, transition|
            if object.class.has_state_machines_key_columns?
              transaction_log = ::TransactionLog.current!
              transaction_log.entries
                             .create!(transaction_loggable: object, event: transition.event, from: transition.from, to: transition.to)
            end
          end
        end

        # Used to retain data about the original object
        before_save    :retain_transaction_log_attributes
        before_destroy :retain_transaction_log_attributes_for_destroy

        # Callbacks to actually store the log entries
        after_save     :register_transaction_log
        after_destroy  :register_transaction_log

        def retain_transaction_log_attributes
          @transaction_loggable_event = new_record? ? 'create' : 'update'
          unless @transaction_loggable_event == 'create'
            @transaction_loggable_attributes = attributes.merge(attributes_in_database)
          end
        end

        def retain_transaction_log_attributes_for_destroy
          @transaction_loggable_event = 'destroy'
          @transaction_loggable_attributes = attributes
        end

        def register_transaction_log
          transaction_log = ::TransactionLog.current!
          transaction_log.entries
                         .create!(transaction_loggable: self,
                                  object: @transaction_loggable_attributes,
                                  object_changes: saved_changes,
                                  event: @transaction_loggable_event)
        end
      end

      class_methods do
        def has_state_machines_key_columns?
          return false unless respond_to?(:state_machines)

          state_machines.keys.all? { |key| column_names.include?(key.to_s) }
        end

        def in_transaction_log(transaction_log)
          transaction_log = ::TransactionLog.find(transaction_log) if transaction_log.is_a?(String)

          where(
            id: transaction_log.entries
                               .where(transaction_loggable_type: name)
                               .select(:transaction_loggable_id)
          )
        end

        def insert_all!(attributes, returning: nil)
          records = super(attributes, returning: attribute_names)
          create_transaction_log_entries(records)

          records
        end

        def insert_all(attributes, returning: nil, unique_by: nil)
          records = super(attributes, returning: attribute_names, unique_by: unique_by)
          create_transaction_log_entries(records)

          records
        end

        def upsert_all(attributes, returning: nil, unique_by: nil)
          records = super(attributes, returning: attribute_names, unique_by: unique_by)
          create_transaction_log_entries(records)

          records
        end

        def upsert(attributes, returning: nil, unique_by: nil)
          upsert_all([attributes], returning: returning, unique_by: unique_by)
        end

        def insert!(attributes, returning: nil)
          insert_all([attributes], returning: returning)
        end

        def insert(attributes, returning: nil, unique_by: nil)
          insert_all!([attributes], returning: returning, unique_by: unique_by)
        end

        private

        def create_transaction_log_entries(records)
          now = Time.now
          transaction_attributes = records.map { |r| { transaction_log_id: ::TransactionLog.current!.id, transaction_loggable_id: r['id'], transaction_loggable_type: name, created_at: now, updated_at: now, object_changes: r.map { |k, v| [k, [nil, v]] } } }
          Transactio::TransactionLogEntry.upsert_all(transaction_attributes)
        end
      end
    end
  end
end
