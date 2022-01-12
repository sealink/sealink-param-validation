# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sealink_param_validation/version'

Gem::Specification.new do |spec|
  spec.name          = 'sealink-param-validation'
  spec.version       = SealinkParamValidation::VERSION
  spec.authors       = ['Sean Earle']
  spec.email         = 'development@travellink.com.au'
  spec.description   = 'Simple validation of params with a concern'
  spec.summary       = 'This is some logic we want to use across many projects so we have extracted it into a gem.'
  spec.homepage      = 'http://github.com/sealink/sealink-param-validation'

  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'rails'
  spec.add_dependency 'dry-schema', '>= 1.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'coverage-kit'
end
