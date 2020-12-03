# frozen_string_literal: true

# User Authentication service
class AuthenticateUser
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    return token if user&.authenticate(password)
  end

  private

  attr_reader :email, :password

  def user
    return @user if defined? @user

    @user = User.find_by(email: email)
  end

  def token
    JsonWebToken.encode(user_id: user.id)
  end
end
