# frozen_string_literal: true

require_dependency 'transactio/models/application_record'

module Transactio
  class TransactionLogEntry < Transactio::ApplicationRecord
    belongs_to :transaction_log, class_name: '::TransactionLog'
    belongs_to :transaction_loggable, polymorphic: true

    default_scope -> { order(created_at: :desc) }
  end
end
