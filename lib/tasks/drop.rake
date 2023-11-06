namespace :db do
  desc 'Drop the database'
  task :drop do
    db_name = 'ruby_on_moon_dev'
    conn = Sequel.connect(
      adapter: 'mysql2',
      host: 'localhost',
      user: 'root',
      password: '',
      database: nil
    )
    conn.run("DROP DATABASE #{db_name};")
    puts "Dropped database #{db_name}"
  end
end
