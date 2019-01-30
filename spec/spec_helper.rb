$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'async_task'
require 'rspec'
require 'byebug'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
