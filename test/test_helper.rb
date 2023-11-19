require 'minitest/autorun'
require 'pry'
require 'zeitwerk'
require_relative '../loader'
require_relative '../db/database'

Sequel::Model.db = DB::Database.instance.connect
Loader.new.load_test

class TestHelper < Minitest::Test
end
