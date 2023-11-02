namespace :db do
  task :create do
    conn = Sequel.connect(
      adapter: 'mysql2',
      host: 'localhost',
      user: 'root',
      password: '',
      database: nil
    )
    db_name = 'ruby_on_moon_dev'
    conn.run("CREATE DATABASE #{db_name};")
    puts "Created database #{db_name}"
  end
end
