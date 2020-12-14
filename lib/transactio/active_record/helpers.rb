# frozen_string_literal: true

require 'active_support/concern'

module Transactio
  module ActiveRecord
    module Helpers
      extend ActiveSupport::Concern

      class_methods do
        def transaction_loggable
          include Transactio::ActiveRecord::TransactionLoggable
        end

        def transaction_loggable?
          included_modules.include?(Transactio::ActiveRecord::TransactionLoggable)
        end
      end
    end
  end
end
