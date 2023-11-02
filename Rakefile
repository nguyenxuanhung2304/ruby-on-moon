require 'sequel'
require 'rake'
require 'pry'

require_relative 'utils/file_parser'
require_relative 'db/database'
require_relative 'utils/db_helper'

# @class RakeTask
# Load all rake tasks in lib/tasks directory
class RakeTask
  extend FileParser
  extend DbHelper

  # @method load
  # Load all rake tasks in lib/tasks, app/models directory.
  # @return [void]
  def load
    RakeTask.load_files 'lib/tasks'
    return unless existed_db?

    RakeTask.require_models
  end

  def existed_db?
    conn = Sequel.connect(
      adapter: 'mysql2',
      host: 'localhost',
      user: 'root',
      password: '',
      database: nil
    )
    conn.fetch('SELECT schema_name FROM information_schema.schemata WHERE schema_name = ?', 'ruby_on_moon_dev').first
  end
end

DATABASE = DB::Database.instance.connect
RakeTask.new.load
