# frozen_string_literal: true

require_dependency 'transactio/models/application_record'

module Transactio
  class TransactionLogEntry < Transactio::ApplicationRecord
    belongs_to :transaction_log, class_name: '::TransactionLog'
    belongs_to :transaction_loggable, polymorphic: true

    default_scope -> { order(created_at: :desc) }

    scope :ascending, -> { reorder(created_at: :asc) }

    def object_change?(attribute)
      return false if object_change_from(attribute) == object_change_to(attribute)

      object_changes.key?(attribute.to_s)
    end

    def object_change(attribute)
      return nil if object_change_from(attribute) == object_change_to(attribute)

      object_changes[attribute.to_s]
    end

    def object_change_from(attribute)
      return nil if object_changes.nil?

      object_changes[attribute.to_s]&.first
    end

    def object_change_to(attribute)
      return nil if object_changes.nil?

      object_changes[attribute.to_s]&.last
    end
  end
end
