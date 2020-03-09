require 'enigma/secret'
require 'minitest/autorun'

class SecretTest < MiniTest::Test
  def test_parses_correctly
    hash = { 'name' => 'Secret', 'items' => [{ 'key' => 'apiKey', 'property_name' => 'key' }, { 'key' => 'apiSecret', 'property_name' => 'secret' }]}
    secret = Enigma::Secret.new(hash: hash)

    assert_equal secret.name, 'Secret'
    assert_equal secret.items.length, 2
  end
end
