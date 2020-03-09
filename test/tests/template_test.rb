require File.join(__dir__, '..', 'test_helper')
require 'fileutils'

class TemplateTest < MiniTest::Test
  def test_rendersCorrectly
    secrets = []

    secret = Enigma::Secret.new(hash: { name: 'Secret', items: [] })
    item1 = Enigma::Item.new(hash: { key: 'apiKey', property_name: 'apiKey' })
    item1.value = 'testApiKey'
    item2 = Enigma::Item.new(hash: { key: 'apiSecret', property_name: 'apiSecret' })
    item2.value = 'testApiSecret'
    secret.items = [item1, item2]
    secrets << secret

    tmp_dir = File.join(__dir__, '.tmp')

    FileUtils.mkdir(tmp_dir) unless File.directory?(tmp_dir)

    template = Enigma::Template.new(secrets: secrets, 
                                    template_path: File.join(__dir__, '..', 'Templatefile'), 
                                    output_path: File.join(tmp_dir, 'testOutput'))
    template.build

    control_content = File.read(File.join(__dir__, '..', 'Template'))
    test_content = File.read(File.join(tmp_dir, 'testOutput'))

    assert_equal control_content, test_content

    FileUtils.rm_rf(tmp_dir)
  end
end
