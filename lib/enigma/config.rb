require 'yaml'

module Enigma

  class Config
    attr_reader :allow_missing_items
    attr_reader :api_key
    attr_reader :aws_region
    attr_reader :categories
    attr_reader :output_path
    attr_reader :template_path

    def initialize(path: 'Enigmafile')
      config = YAML::load_file(path)
      @allow_missing_items = config['allow_missing_items']
      @api_key = config['api_key']
      @aws_region = config['aws_region']
      @categories = config['categories']
      @output_path = config['output_path']
      @output_file = config['output_file']
      @template_file = config['template_path']
    end
  end

end
