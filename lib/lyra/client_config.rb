module Lyra
  class ClientConfig
    attr_reader :access_key_id
    attr_reader :secret_access_key
    attr_reader :aws_region
    attr_reader :environment

    def initialize(access_key_id: String, secret_access_key: String, aws_region: String, environment: String)
      @access_key_id = access_key_id
      @secret_access_key = secret_access_key
      @aws_region = aws_region
      @environment = environment
    end
  end
end
