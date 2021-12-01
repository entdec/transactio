# frozen_string_literal: true

require_dependency 'transactio/models/application_record'

module Transactio
  class TransactionLogEntry < Transactio::ApplicationRecord
    belongs_to :transaction_log, class_name: '::TransactionLog'
    belongs_to :transaction_loggable, polymorphic: true

    default_scope -> { order(created_at: :desc) }

    scope :ascending, -> { reorder(created_at: :asc) }
    scope :descending, -> { reorder(created_at: :desc) }
    scope :with_object_change_from, lambda { |field, change_from|
                                      where("object_changes -> '#{field}' ->> 0 = ?", change_from)
                                    }
    scope :with_object_change_to, ->(field, change_to) { where("object_changes -> '#{field}' ->> 1 = ?", change_to) }

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
