require 'simplecov'
require 'async_task'
require 'rspec'
require 'byebug'
require 'database_cleaner'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


# Create an in-memory database and run our template migration
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Migration.verbose = false

require_relative './../lib/generators/async_task/install/templates/create_async_task'
CreateAsyncTask.new.change

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
