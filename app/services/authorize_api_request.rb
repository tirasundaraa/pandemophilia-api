# frozen_string_literal: true

# Authorization service
class AuthorizeApiRequest
  attr_reader :headers

  class << self
    def call(headers)
      new(headers).call
    end
  end

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  def user
    return unless decoded_auth_token.present?
    return @user if defined? @user

    @user = User.find_by(id: decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
  end

  def auth_token
    return unless headers['Authorization'].present?

    @auth_token ||= headers['Authorization'].split(' ').last
  end
end
