require_relative '../test_helper'

class UserTest < TestHelper
  def setup
    @user = users(:one)
  end

  def test_name_cannot_empty
    @user.name = nil
    assert_equal @user.valid?, false
  end

  def test_age_cannot_empty
    @user.age = nil
    assert_equal @user.valid?, false
  end
end
