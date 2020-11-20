require 'transactio/version'
require 'transactio/active_record/helpers'
require 'transactio/models/application_record'
require 'transactio/models/transaction_log'
require 'transactio/models/transaction_log_entry'

module Transactio
  class Error < StandardError; end
end

ActiveSupport.on_load(:active_record) do
  include Transactio::ActiveRecord::Helpers
end
