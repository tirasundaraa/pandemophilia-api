# frozen_string_literal: true

module UserServices
  # UpdateUser service
  class UpdateUser
    include Common
    include Dry::Monads[:do]

    class << self
      def call(user_id, user_params)
        new(user_id, user_params).call
      end
    end

    attr_reader :user_id, :user_params

    def initialize(user_id, user_params)
      @user_id      = user_id
      @user_params  = user_params
    end

    def call
      user = yield find_user(user_id)
      user = yield update_user(user, user_params)

      Success(OpenStruct.new({ user: user }))
    end

    private

    def update_user(user, params)
      if user.update(params)
        Success(user)
      else
        Failure(OpenStruct.new({ code: 422, message: user.errors.full_messages.join(",") }))
      end
    end
  end
end
