require File.join(__dir__, '..', 'test_helper')
require 'lyra/config'
require 'lyra/secret'
require 'minitest/autorun'

class SecretTest < MiniTest::Test
  def test_parses_correctly_from_hash
    hash = { name: 'Secret', items: [{ key: 'apiKey', property_name: 'key' }, { key: 'apiSecret', property_name: 'secret' }]}
    secret = Lyra::Secret.new(hash: hash)

    assert_equal secret.name, 'Secret'
    assert_equal secret.items.length, 2
  end

  def test_parses_correctly_from_config
    config = Lyra::Config.new(path: File.join(__dir__, '..', 'Lyrafile'))
    secret = Lyra::Secret.new(hash: config.secrets[0])
    
    assert_equal secret.name, 'someRandomThirdParty'
    assert_equal secret.items.length, 2
  end
end
