require 'squash_migrations'
require 'rails'
module SquashMigrations
  class Railtie < Rails::Railtie
    railtie_name :squash_migrations

    rake_tasks do
      load 'tasks/squash_migrations.rake'
    end
  end
end