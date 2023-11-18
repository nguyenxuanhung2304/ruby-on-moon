require 'minitest/autorun'
require 'pry'
require_relative '../utils/db_helper'

class TestHelper < Minitest::Test
  include DbHelper

  def setup
    require_models
  end
end
