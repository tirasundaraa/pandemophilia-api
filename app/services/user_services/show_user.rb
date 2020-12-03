# frozen_string_literal: true

module UserServices
  # ShowUser service
  class ShowUser
    include Common
    include Dry::Monads[:do]

    class << self
      def call(user_id)
        new(user_id).call
      end
    end

    attr_reader :user_id

    def initialize(user_id)
      @user_id      = user_id
    end

    def call
      user = yield find_user(user_id)

      Success(OpenStruct.new({ user: user }))
    end
  end
end
