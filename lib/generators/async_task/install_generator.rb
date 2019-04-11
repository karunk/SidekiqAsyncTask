require 'rails/generators'
require 'rails/generators/migration'

module AsyncTask
  class InstallGenerator < ::Rails::Generators::Base
    include Rails::Generators::Migration
    desc "Add the migrations for AsyncTask"
    source_root File.expand_path("./install/templates", __dir__)

    def self.next_migration_number(path)
      next_migration_number = current_migration_number(path) + 1
      ActiveRecord::Migration.next_migration_number(next_migration_number)
    end

    def copy_migrations
      migration_template "create_async_task.rb",
        "db/migrate/create_async_task.rb"
    end

  end
end

