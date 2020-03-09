require 'yaml'

module Enigma

  class Config
    attr_reader :allow_missing_items
    attr_reader :access_key_id
    attr_reader :secret_access_key
    attr_reader :aws_region
    attr_reader :environment
    attr_reader :output_path
    attr_reader :secrets
    attr_reader :template_path

    def initialize(path: 'Enigmafile')
      config = YAML::load_file(path)
      @allow_missing_items = config['allow_missing_items']
      @access_key_id = config['access_key_id']
      @secret_access_key = config['secret_access_key']
      @aws_region = config['aws_region']
      @environment = config['environment']
      @output_path = config['output_path']
      @secrets = config['secrets']
      @template_path = config['template_path']
    end
  end

end
