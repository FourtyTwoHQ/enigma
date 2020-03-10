require 'enigma/item'
require 'enigma/secret'
require 'enigma/template'
require 'minitest/autorun'
require 'fileutils'

class TemplateTest < MiniTest::Test
  def test_parses_correctly
    test_dir = File.join(__dir__, '..')
    tmp_dir = File.join(__dir__, '.tmp')
    output_file = File.join(tmp_dir, 'output')

    secrets = []

    secret = Enigma::Secret.new(hash: { 'name' => 'Secret', 'items' => [] })
    item1 = Enigma::Item.new(hash: { 'key' => 'apiKey', 'property_name' => 'key' })
    item1.value = 'testApiKey'
    item2 = Enigma::Item.new(hash: { 'key' => 'apiSecret', 'property_name' => 'secret' })
    item2.value = 'testApiSecret'
    secret.items = [item1, item2]
    secrets.append(secret)
    
    FileUtils.mkdir(tmp_dir) unless File.directory?(tmp_dir)

    template = Enigma::Template.new(secrets: secrets, 
                                    template_path: File.join(test_dir, 'Templatefile'),
                                    output_path: output_file)
    content = template.render

    assert_equal File.read(File.join(test_dir, 'Template.fixture')), content

    FileUtils.rm_rf(tmp_dir)
  end
end
