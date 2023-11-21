class User < ApplicationModel
  def validate
    super

    validates_presence %i[name]
    validates_presence %i[age]
  end
end
