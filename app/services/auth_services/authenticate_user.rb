# frozen_string_literal: true

module AuthServices
  # User Authentication service
  class AuthenticateUser
    include Dry::Monads[:result, :do]

    class << self
      def call(auth_params)
        new(auth_params).call
      end
    end

    def initialize(auth_params)
      @email    = auth_params.fetch(:email)
      @password = auth_params.fetch(:password)
    end

    def call
      user = yield find_user_by_email(email)
      token = yield authenticate_user(user, password)

      Success(OpenStruct.new({ user: user, token: token }))
    end

    private

    attr_reader :email, :password

    def authenticate_user(user, pwd)
      if user.authenticate(pwd)
        token = JsonWebToken.encode(user_id: user.id)

        Success(token)
      else
        Failure(invalid_credentials_error)
      end
    end

    def find_user_by_email(email)
      user = User.find_by(email: email)

      if user
        Success(user)
      else
        Failure(invalid_credentials_error)
      end
    end

    def invalid_credentials_error
      @invalid_credentials_error ||= OpenStruct.new({ code: 401, message: :invalid_credentials })
    end
  end
end
