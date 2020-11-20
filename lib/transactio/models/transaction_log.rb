# frozen_string_literal: true

module Transactio
  class TransactionLog < ApplicationRecord
    self.abstract_class = true

    has_many :entries, class_name: 'Transactio::TransactionLogEntry'

    # belongs_to :user, optional: true
    # belongs_to :location, optional: true
    # belongs_to :account, optional: true

    after_commit :clear_current!
    # before_create :register_user

    default_scope -> { order(created_at: :desc) }

    def self.current!
      Current.transaction_log ||= create!
    end

    def name
      id.split('-').first.upcase
    end

    private

    # def register_user
    #   self.user = Current.user
    #   self.account = Current.account
    #   self.location = Current.location
    # end

    def clear_current!
      Current.transaction_log = nil
    end
  end
end
