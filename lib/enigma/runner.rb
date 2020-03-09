require 'erb'
require 'json'

module Enigma

  class Runner

    def initialize(options: Hash)
      @options = options
    end

    def run
      begin
        raise Thor::Error, Rainbow("Cannot find Enigma at #{@options[:config]}").red unless File.exist?(@options[:config])

        @config = Enigma::Config.new(path: @options[:config])

        api_key = @options[:api_key] || ENV[@config.api_key]
        raise Thor::Error, Rainbow("api_key cannot be nil").red if api_key.nil?
        raise Thor::Error, Rainbow("api_key cannot be empty").red if api_key.empty?

        aws_region = config.aws_region
        raise Thor::Error, Rainbow("aws_region cannot be nil").red if api_key.nil?
        raise Thor::Error, Rainbow("aws_region cannot be empty").red if api_key.empty?

        client_config = Enigma::ClientConfig.new(:api_key => api_key,
                                                 :aws_region => aws_region,
                                                 :environment => config.environment)
        @client = Enigma::Client.new(client_config)

        category_list = []

        categories = config.categories
        categories.each do |c|
          category = Enigma::Category.new(c)
          item_list = []

          secret = JSON.parse(@client.fetch_secret(secret_name: category.id))
          category.items.each do |i|
            item = Enigma::Item.new(i)

            raise Thor::Error, Rainbow("Could not").red if secret[item.key].nil && !config.allow_missing_items

            item.value = secret[item.key]
            item_list.append(item)
          end

          category.items = item_list
          category_list.append(category)
        end

        template = Enigma::Template.new(:categories => category_list,
                                        :template_path => config.template_path,
                                        :output_path => config.output_path)
        template.build
      end
    end
  end
end
