require 'yaml'

module Enigma

  class Config
    attr_reader :output_path
    attr_reader :output_file
    attr_reader :template_path
    attr_reader :template_file
    attr_reader :environment
    attr_reader :apiKey

    def initialize(path: 'Enigmafile')
      config = YAML::load_file(path)
      @output_path = config['output_path']
      @output_file = config['output_file']
      @template_file = config['template_file']
      @environment = config['environment']
      @apiKey = config['apiKey']
      @categories = Category.new(hash: config['categories'])
    end
  end

end
