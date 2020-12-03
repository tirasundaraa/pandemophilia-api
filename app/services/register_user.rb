# frozen_string_literal: true

# User Registration service
class RegisterUser
  attr_reader :user_params

  class << self
    def call(user_params)
      new(user_params).call
    end
  end

  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user = User.new(user_params)

    if user.save
      OpenStruct.new({ success?: true, user: user })
    else
      OpenStruct.new({ success?: false, message: user.errors.full_messages.join(",") })
    end
  end
end
