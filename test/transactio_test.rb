require "test_helper"

class TransactioTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Transactio::VERSION
  end
end
