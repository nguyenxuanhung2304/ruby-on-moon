require 'minitest/autorun'
require 'pry'
require 'zeitwerk'

require_relative 'fixture'

class TestHelper < Minitest::Test
  include Fixture
end
