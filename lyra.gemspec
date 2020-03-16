lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lyra/version'

Gem::Specification.new do |spec|
  spec.name          = 'lyra'
  spec.version       = Lyra::VERSION
  spec.authors       = ['Mat Cartmill']
  spec.email         = ['mat@hellomustard.com']

  spec.summary       = %q{A gem for pulling secrets from AWS Secrets Manager.}
  spec.description   = %q{Retrieves secrets to from AWS Secrets Manager and creates a file matching your template with your secrets populated.}
  spec.homepage      = 'https://github.com/HelloMustard/lyra'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/HelloMustard/lyra'
  spec.metadata['changelog_uri'] = 'https://github.com/HelloMustard/lyra'

  spec.required_ruby_version = '>= 2.6'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.7.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'simplecov', '~> 0.18'
  spec.add_runtime_dependency 'aws-sdk-secretsmanager', '~> 1.32.0'
  spec.add_runtime_dependency 'json', '~> 2.3.0'
  spec.add_runtime_dependency 'rainbow', '~> 3.0.0'
  spec.add_runtime_dependency 'terminal-table', '~> 1.8.0'
  spec.add_runtime_dependency 'thor', '~> 0.20.3'
end
