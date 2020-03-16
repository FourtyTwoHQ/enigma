require 'yaml'

module Lyra

  class Config
    attr_reader :access_key_id
    attr_reader :secret_access_key
    attr_reader :aws_region
    attr_reader :environment
    attr_reader :output_path
    attr_reader :secrets
    attr_reader :template_path

    def initialize(path: 'Lyrafile')
      config = YAML::load_file(path).transform_keys(&:to_sym)
      @access_key_id = config[:access_key_id]
      @secret_access_key = config[:secret_access_key]
      @aws_region = config[:aws_region]
      @environment = config[:environment]
      @output_path = config[:output_path]
      @secrets = config[:secrets]
      @template_path = config[:template_path]
    end
  end

end
