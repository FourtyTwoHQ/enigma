require 'erb'

module Lyra
  class Template
    attr_reader :secrets
    attr_reader :template_path
    attr_reader :output_path

    def initialize(secrets: Array, template_path: String)
      @secrets = secrets
      @template_path = template_path
    end

    def render
      ERB.new(File.read(@template_path), trim_mode: '<>').result(binding)
    end

    def generate(output_path: String)
      File.open(output_path, 'w+') do |f|
        f.write(render)
        f.close
      end
    end
  end
end
