# frozen_string_literal: true

module UserServices
  # CreateUser service
  class CreateUser
    include Dry::Monads[:result, :do]

    class << self
      def call(user_params)
        new(user_params).call
      end
    end

    attr_reader :user_params

    def initialize(user_params)
      @user_params = user_params
    end

    def call
      user = yield register_user(user_params)
      token = yield generate_auth_token(user.id)

      Success(OpenStruct.new({ code: 201, user: user, auth_token: token }))
    end

    private

    def generate_auth_token(user_id)
      token = JsonWebToken.encode(user_id: user_id)

      Success(token)
    end

    def register_user(params)
      user = User.new(params)

      if user.save
        Success(user)
      else
        Failure(OpenStruct.new({ code: 422, message: user.errors.messages }))
      end
    end
  end
end
