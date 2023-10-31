require 'sequel'
require 'singleton'

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

    # Includes the Singleton module to ensure a single instance of Database.
    include Singleton

    # Initializes a new instance of Database and establishes a database connection using Sequel.
    def initialize
      # FIXME: move Sequel config to an XML file
      @connect = Sequel.connect(
        adapter: 'mysql2',
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'ruby_on_moon_dev'
      )

      # Load Sequel migrations extension.
      Sequel.extension :migration
    end
  end
end
