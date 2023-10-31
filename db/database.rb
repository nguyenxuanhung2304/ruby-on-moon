require 'sequel'
require 'singleton'

module DB
  class Database
    attr_reader :connect

    include Singleton

    def initialize
      # FIXME: move sequel config to xml file
      @connect = Sequel.connect(
        adapter: 'mysql2',
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'ruby_on_moon_dev'
      )

      Sequel.extension :migration
    end
  end
end
