require File.join(__dir__, '..', 'test_helper')
require 'enigma/config'
require 'enigma/secret'
require 'minitest/autorun'

class SecretTest < MiniTest::Test
  def test_parses_correctly_from_hash
    hash = { name: 'Secret', items: [{ key: 'apiKey', property_name: 'key' }, { key: 'apiSecret', property_name: 'secret' }]}
    secret = Enigma::Secret.new(hash: hash)

    assert_equal secret.name, 'Secret'
    assert_equal secret.items.length, 2
  end

  def test_parses_correctly_from_config
    config = Enigma::Config.new(path: File.join(__dir__, '..', 'Enigmafile'))
    secret = Enigma::Secret.new(hash: config.secrets[0])
    
    assert_equal secret.name, 'someRandomThirdParty'
    assert_equal secret.items.length, 2
  end
end
