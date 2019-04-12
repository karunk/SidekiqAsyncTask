
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sidekiq_async_task/version"

Gem::Specification.new do |spec|
  spec.name          = "sidekiq_async_task"
  spec.version       = SidekiqAsyncTask::VERSION
  spec.authors       = ["Karun"]
  spec.email         = ["karunk@live.com"]

  spec.summary       = "A lightweight gem to ensure safe execution of asyncronous Sidekiq Jobs within a transaction in Rails in a DB backed way."
  spec.description   = "Making asyncronous transactional sidekiq jobs possible"
  spec.homepage      = "http://vkarun.me/asynctask.html"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/karunk/asynctask"
    spec.metadata["changelog_uri"] = "https://github.com/karunk/asynctask"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
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
