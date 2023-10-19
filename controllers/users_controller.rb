require_relative 'application_controller'

class UsersController < ApplicationController
  def index
    @title = 'Ruby on Moon 1111'
    @username = 'User test'
  end

  def show
    @title = 'Ruby on Moon 333'
  end
end
