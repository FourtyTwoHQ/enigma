require 'git'
require 'rainbow'
require 'terminal-table'
require 'thor'

module Enigma
  class Error < StandardError; end

  class CLI < Thor
    class_option :verbose, aliases: :v, type: :boolean, default: false

    desc ''
    def push
      puts 'pushing...'
    end
  end

end
