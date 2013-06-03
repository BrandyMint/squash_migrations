namespace :db do
  desc 'Squash migrations'
  task :squash_migrations => 'db:migrate' do
    migration_proxies = ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_path)
    last_migration_proxy = migration_proxies.last
    migration_proxies = migration_proxies.take(migration_proxies.size - 1)
    migration_proxies.each do |migration_proxy|
      remove_migration_file(migration_proxy.filename)
    end

    FileUtils.copy('db/schema.rb', last_migration_proxy.filename)
    if git_repo?
      `git add #{last_migration_proxy.filename}`
    end
  end

  def remove_migration_file(filename)
    if git_repo?
      `git rm #{filename}`
    else
      File.delete(filename)
    end
  end

  def git_repo?
    system('git status')
  end
end