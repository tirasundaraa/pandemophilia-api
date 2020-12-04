# frozen_string_literal: true

module UserServices
  # TogglePandemophilia service
  class TogglePandemophilia
    include Common
    include Dry::Monads[:do]

    class << self
      def call(user_id)
        new(user_id).call
      end
    end

    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def call
      user = yield find_user(user_id)
      user = yield toggle_pandemophilia(user)

      Success(OpenStruct.new({ user: user }))
    end

    private

    def toggle_pandemophilia(user)
      if user.toggle(:is_pandemophilia).save
        Success(user)
      else
        Failure(OpenStruct.new({ code: 422, message: user.errors.messages }))
      end
    end
  end
end
