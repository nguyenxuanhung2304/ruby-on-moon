require_relative '../test_helper'
require_relative '../../db/database'

class UserTest < TestHelper
  def test_name_cannot_empty
    # FIXME: use setup for create an instance of User
    @user = User.new({ name: nil, age: 21 })
    assert_equal @user.valid?, false
  end

  def test_age_cannot_empty
    # FIXME: use setup for create an instance of User
    @user = User.new({ name: 'user', age: nil })
    assert_equal @user.valid?, false
  end
end
