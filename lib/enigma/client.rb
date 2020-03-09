require 'aws-sdk-secretsmanager'

module Enigma
  class Client

    def initialize(configuration: Enigma::ClientConfig)
      @client = Aws::SecretsManager::Client.new(region: configuration.aws_region)
    end

    def fetch_secret(secret_name: String)
      environment_prefix = ''
      environment_prefix = "#{config.environment}/" unless config.environment.nil? && config.environment.empty?

      response = @client.get_secret_value({
        secret_id: "#{environment_prefix}#{secret_name}"
      })

      response.secret_string
    end

  end
end