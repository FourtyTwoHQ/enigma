require File.join(__dir__, '..', 'test_helper')
require 'lyra/config'
require 'minitest/autorun'

class ConfigTest < MiniTest::Test
  def test_parses_strings_correctly
    config = Lyra::Config.new(path: File.join(__dir__, '..', 'Lyrafile'))
    assert_equal config.access_key_id, 'MY_AWS_KEY'
    assert_equal config.secret_access_key, 'MY_AWS_SECRET'
    assert_equal config.aws_region, 'us-east-2'
  end

  def test_config_arrays_do_not_get_symbolized_keys
    config = Lyra::Config.new(path: File.join(__dir__, '..', 'Lyrafile'))
    assert_equal config.secrets[0]['name'], 'someRandomThirdParty'
    assert_nil config.secrets[0][:name]
  end
end
