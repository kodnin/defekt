# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'defekt/version'

Gem::Specification.new do |spec|
  spec.name          = 'defekt'
  spec.version       = Defekt::VERSION
  spec.authors       = ['David Boot']
  spec.email         = ['kodnin@gmail.com']

  spec.summary       = 'Micro testing framework'
  spec.description   = 'Micro testing framework'
  spec.homepage      = 'https://github.com/kodnin/defekt'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'minitest', '~> 5.5'
  spec.add_development_dependency 'pry', '~> 0.10'
end
