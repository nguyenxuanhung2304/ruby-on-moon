class User < Sequel::Model
  plugin :validation_helpers

  def validate
    super

    validates_presence %i[name]
    validates_presence %i[age]
  end
end
