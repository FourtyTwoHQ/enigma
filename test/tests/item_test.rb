require File.join(__dir__, '..', 'test_helper')
require 'lyra/config'
require 'lyra/item'
require 'lyra/secret'
require 'minitest/autorun'

class ItemTest < MiniTest::Test
  def test_parses_correctly_with_default_empty_value
    hash = { key: 'apiKey', property_name: 'key' }
    item = Lyra::Item.new(hash: hash)

    assert_equal item.key, 'apiKey'
    assert_equal item.property_name, 'key'
    assert_equal item.value, ''
  end

  def test_parses_correctly_from_config
    config = Lyra::Config.new(path: File.join(__dir__, '..', 'Lyrafile'))
    secret = Lyra::Secret.new(hash: config.secrets[0])
    item1 = Lyra::Item.new(hash: secret.items[0])
    item2 = Lyra::Item.new(hash: secret.items[1])
    
    assert_equal item1.key, 'apiKey'
    assert_equal item1.property_name, 'key'
    assert_equal item2.key, 'apiSecret'
    assert_equal item2.property_name, 'secret'
  end
end
