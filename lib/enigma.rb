require 'git'
require 'rainbow'
require 'enigma/config'
require 'enigma/logger'
require 'enigma/runner'
require 'enigma/version'
require 'terminal-table'
require 'thor'

module Enigma
  class Error < StandardError; end

  class CLI < Thor
    class_option :verbose, aliases: :v, type: :boolean, default: false

    desc 'exec --api_key <AWS API key> --config <path to Enigmafile>', 'Pulls the secrets from your AWS Secrets Manager instance and builds a file from template'
    option :api_key, aliases: :b, type: :string
    option :config, aliases: :c, type: :string, default: "#{ENV['PWD']}/Enigmafile"
    option :working_directory, aliases: :d, type: :string, default: '.'
    def exec
      configure_logger(verbose: options[:verbose])

      runner = Runner.new(options: options)
      runner.run
    end

    private

    def configure_logger(verbose: Boolean)
      log.level = verbose ? Logger::DEBUG : Logger::INFO
    end
  end

end
