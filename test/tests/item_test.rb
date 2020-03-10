require File.join(__dir__, '..', 'test_helper')
require 'enigma/item'
require 'minitest/autorun'

class ItemTest < MiniTest::Test
  def test_parses_correctly_with_default_empty_value
    hash = { key: 'apiKey', property_name: 'key' }
    item = Enigma::Item.new(hash: hash)

    assert_equal item.key, 'apiKey'
    assert_equal item.property_name, 'key'
    assert_equal item.value, ''
  end
end
