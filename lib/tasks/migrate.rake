require_relative '../../db/database'

db = DB::Database.instance.connect

namespace :db do
  desc 'Run migrate'
  task :migrate do
    Sequel::Migrator.run(db, 'db/migrations', allow_missing_migration_files: true)
    puts 'Run migrate'
  end

  desc 'Create a migration file'
  task :create_migration, [:name] do |_t, args|
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')

    migration_filename = "db/migrations/#{timestamp}_#{args[:name]}.rb"

    File.open(migration_filename, 'w') do |file|
      file.puts <<~RUBY
        Sequel.migration do
          change do
            create_table(:name) do
              primary_key :id
              String :column1
              String :column2
            end
          end
        end
      RUBY
    end

    puts "Created a migration file: #{migration_filename}"
  end
end
