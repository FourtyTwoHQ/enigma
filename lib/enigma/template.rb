require 'erb'

module Enigma
  class Template
    attr_reader :categories
    attr_reader :template_path
    attr_reader :output_path

    def initialize(categories: Array, template_path: String, output_path: String)
      @categories = categories
      @template_path = template_path
      @output_path = output_path
    end

    def render
      ERB.new(File.read(@template_path).result(binding))
    end

    def build
      File.open(@output_path, 'w+') do |f|
        f.write(render)
        f.close
      end
    end
  end
end