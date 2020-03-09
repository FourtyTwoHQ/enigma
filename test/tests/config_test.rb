require File.join(__dir__, '..', 'test_helper')

class ConfigTest < MiniTest::Test
  def test_parsesCorrectly
    config = Enigma::Config.new(path: File.join(__dir__, '..', 'Enigmafile'))
    assert_equal config.access_key_id, 'MY_AWS_KEY'
    assert_equal config.secret_access_key, 'MY_AWS_SECRET'
    assert_equal config.aws_region, 'us-east-2'
  end
end
