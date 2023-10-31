# The `UsersController` class is responsible for managing user-related actions.
#
# This controller handles requests related to users, such as listing users in the index action.
class UsersController < ApplicationController
  def index
    @user = User.new('User test', 23)
  end
end
