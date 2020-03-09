module Enigma
  class ClientConfig
    attr_reader :api_key
    attr_reader :aws_region
    attr_reader :environment

    def initialize(api_key: String, aws_region: String, environment: String)
      @api_key = api_key
      @aws_region = aws_region
      @environment = environment
    end
  end
end