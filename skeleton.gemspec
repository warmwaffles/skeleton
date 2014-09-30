# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skeleton/version'

Gem::Specification.new do |spec|
  spec.name          = 'skeleton'
  spec.version       = Skeleton::VERSION
  spec.authors       = ['Matthew Johnston']
  spec.email         = ['warmwaffles@gmail.com']
  spec.summary       = %q{Construct an api skeleton for options}
  spec.description   = %q{Construct an api skeleton for options}
  spec.homepage      = 'https://github.com/warmwaffles/skeleton'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency('multi_json')

  spec.add_development_dependency('bundler', '~> 1.6')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('minitest')
end
