require 'squash_migrations/version'

module SquashMigrations
  require 'squash_migrations/railtie' if defined?(Rails)
end
