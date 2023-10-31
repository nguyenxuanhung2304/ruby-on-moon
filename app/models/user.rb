# The `User` class represents a user with a name and age.
#
# This class is used to create user objects with a name and age.
#
# @example
#   user = User.new("John", 30)
#   puts user.name
#   # => "John"
#   puts user.age
#   # => 30
class User
  # @!attribute [r] name
  # @return [String] The name of the user.
  attr_reader :name

  # @!attribute [r] age
  # @return [Integer] The age of the user.
  attr_reader :age

  # Initializes a new User with the specified name and age.
  #
  # @param name [String] The name of the user.
  # @param age [Integer] The age of the user.
  def initialize(name, age)
    @name = name
    @age = age
  end
end
