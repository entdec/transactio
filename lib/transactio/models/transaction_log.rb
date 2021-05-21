# frozen_string_literal: true

module Transactio
  class TransactionLog < ApplicationRecord
    self.abstract_class = true

    has_many :entries, class_name: 'Transactio::TransactionLogEntry'

    after_rollback :clear_current!
    after_commit :clear_current!

    default_scope -> { order(created_at: :desc) }

    def self.current!
      Current.transaction_log ||= create!
    end

    def name
      id.split('-').first.upcase
    end

    private

    def clear_current!
      Current.transaction_log = nil
    end
  end
end
