# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'async_task/version'

Gem::Specification.new do |spec|
  spec.name          = "asynctask"
  spec.version       = AsyncTask::VERSION
  spec.authors       = ["Karun"]
  spec.email         = ["karunk@live.com"]

  spec.summary       = "A lightweight gem to ensure safe execution of asyncronous Sidekiq Jobs within a transaction in Rails in a DB backed way."
  spec.description   = ""
  spec.homepage      = "http://www.google.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'activerecord'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov" 
  spec.add_development_dependency "generator_spec" 
  spec.add_development_dependency "byebug" 
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner'
end
