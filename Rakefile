require 'sequel'
require 'rake'
require 'pry'
require 'dotenv/tasks'

require_relative 'utils/file_parser'
require_relative 'utils/db_helper'
require_relative 'db/database'
require_relative 'loader'

# @class RakeTask
# Load all rake tasks in lib/tasks directory
class RakeTask
  extend FileParser
  extend DbHelper

  class << self
    # @method load_tasks
    # Load all rake tasks in lib/tasks, app/models directory.
    # @return [void]
    def load_tasks
      RakeTask.load_files 'lib/tasks'
      return unless existed_db?

      Loader.new.load_test
    end

    def existed_db?
      # FIXME: reuse conn in another place
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
end

DATABASE = DB::Database.instance.connect if RakeTask.existed_db?
RakeTask.load_tasks
