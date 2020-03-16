require File.join(__dir__, '..', 'test_helper')
require 'lyra/item'
require 'lyra/secret'
require 'lyra/template'
require 'minitest/autorun'
require 'fileutils'

class TemplateTest < MiniTest::Test
  def test_parses_correctly
    test_dir = File.join(__dir__, '..')

    secrets = []

    secret = Lyra::Secret.new(hash: { name: 'Secret', items: [] })
    item1 = Lyra::Item.new(hash: { key: 'apiKey', property_name: 'key' })
    item1.value = 'testApiKey'
    item2 = Lyra::Item.new(hash: { key: 'apiSecret', property_name: 'secret' })
    item2.value = 'testApiSecret'
    secret.items = [item1, item2]
    secrets.append(secret)
    
    template = Lyra::Template.new(secrets: secrets, template_path: File.join(test_dir, 'Templatefile'))
    content = template.render

    assert_equal File.read(File.join(test_dir, 'Template.fixture')), content
  end
end
