# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fitbyte/version'

Gem::Specification.new do |spec|
  spec.name          = "fitbyte"
  spec.version       = Fitbyte::VERSION
  spec.authors       = ["Zoran Pesic"]
  spec.email         = ["zoran1991@gmail.com"]

  spec.summary       = %q{This gem allows interaction with Fitbit's REST API.}
  spec.homepage      = Fitbyte::REPO_URL
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_runtime_dependency     "oauth2", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
