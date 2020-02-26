module Enigma

    class Runner

        def initialize(name: String, options: Hash, driver: lambda)
            @name = name
            @options = options
            @driver = driver
        end

        def run
            begin
                print_command_config(name: @name)

                raise Thor::Error, Rainbow("Cannot find Enigma at #{@options[:config]}").red unless File.exist?(@options[:config])

                @config = Enigma::Config.new(path: @options[:config])
                bundle_id = @options[:bundle_id] || @config.bundles.first.id

                print_enigma_config

                @apiKey = @options[:apiKey] || ENV[@config.apiKey]
                raise Thor::Error, Rainbow("apiKey cannot be nil").red if @apiKey.nil?
                raise Thor::Error, Rainbow("apiKey cannot be empty").red if @apiKey.empty?
                
            end
        end
    end
end