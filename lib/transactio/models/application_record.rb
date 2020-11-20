# frozen_string_literal: true

module Transactio
  class ApplicationRecord < ::ActiveRecord::Base
    self.abstract_class = true
  end
end
