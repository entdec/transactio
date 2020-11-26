# frozen_string_literal: true

require 'active_record'

module Transactio
  class ApplicationRecord < ::ActiveRecord::Base
    self.abstract_class = true
  end
end
