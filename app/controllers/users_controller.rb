class UsersController < ApplicationController
  def index
    @user = User.new('User test', 23)
  end
end
