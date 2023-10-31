namespace :db do
  desc 'Run seed'
  task :seed do
    seed_file_path = File.join(Dir.pwd, 'db/seed.rb')
    load seed_file_path
  end
end
