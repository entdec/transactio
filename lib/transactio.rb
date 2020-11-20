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

# Require frameworks
if defined?(::Rails)
  # Rails module is sometimes defined by gems like rails-html-sanitizer
  # so we check for presence of Rails.application.
  if defined?(::Rails.application)
    require 'transactio/frameworks/rails'
  else
    ::Kernel.warn(::PaperTrail::E_RAILS_NOT_LOADED)
  end
end
