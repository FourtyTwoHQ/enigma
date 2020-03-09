require 'aws-sdk-secretsmanager'

module Enigma
  class Client

    def initialize(config: Enigma::ClientConfig)
      @config = config
      credentials = Aws::Credentials.new(@config.access_key_id, @config.secret_access_key)
      @client = Aws::SecretsManager::Client.new(credentials: credentials, region: @config.aws_region)
    end

    def fetch_secret(secret_name: String)
      response = @client.get_secret_value({
        secret_id: make_secret_name(from: secret_name)
      })

      response.secret_string
    end

    private

    def make_secret_name(from: String)
      environment_prefix = ''
      environment_prefix = "#{@config.environment}/" unless @config.environment.nil? || @config.environment.empty?
      "#{environment_prefix}#{from}"
    end

  end
end