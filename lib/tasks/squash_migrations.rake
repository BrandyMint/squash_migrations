namespace :db do
  desc 'Squash migrations'
  task :squash_migrations => 'db:migrate' do
    migration_proxies = ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_path)
    last_migration_proxy = migration_proxies.last
    migration_proxies = migration_proxies.take(migration_proxies.size - 1)
    migration_proxies.each do |migration_proxy|
      remove_migration_file(migration_proxy.filename)
    end

    FileUtils.cp('db/schema.rb', last_migration_proxy.filename)

    file_array = File.readlines(last_migration_proxy.filename)
    index = file_array.find_index { |item| item.match('ActiveRecord::Schema.define') }
    file_array.shift(index + 1)

    file_array.insert(0, "class #{last_migration_proxy.name} < ActiveRecord::Migration", '  def up')

    file_array << '' << '  def down' << "    puts '>>> Do not rollback first migration!'" << '    raise' << '  end' << 'end'

    File.open(last_migration_proxy.filename, "w") do |f|
      file_array.each { |line| f.puts(line) }
    end

    if git_repo?
      `git add db/schema.rb`
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