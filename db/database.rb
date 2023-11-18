require 'sequel'
require 'singleton'

require_relative '../utils/db_helper'

# The `DB` module provides a database connection using Sequel and follows the Singleton pattern.
#
# This module contains the `Database` class, which ensures that only one database connection instance exists.
module DB
  # The `Database` class provides a singleton database connection instance using Sequel.
  #
  # This class initializes a database connection and provides a connection instance to other parts of the application.
  class Database
    # @!attribute [r] connect
    #   @return [Sequel::Database] The Sequel database connection instance.
    attr_reader :connect

    include Singleton

    extend DbHelper

    # Initializes a new instance of Database and establishes a database connection using Sequel.
    def initialize
      config = DB::Database.load_db_config
      dev_config = config['development']

      Sequel.extension :migration

      @connect = Sequel.connect(
        adapter: dev_config['adapter'],
        host: dev_config['host'],
        user: dev_config['username'],
        password: dev_config['password'],
        database: dev_config['database']
      )
    end
  end
end
