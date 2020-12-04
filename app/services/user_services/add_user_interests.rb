# frozen_string_literal: true

module UserServices
  # AddUserInterests service
  class AddUserInterests
    include Common
    include Dry::Monads[:do]

    class << self
      def call(user_id, interest_ids:)
        new(user_id, interest_ids: interest_ids).call
      end
    end

    def initialize(user_id, interest_ids:)
      @user_id      = user_id
      @interest_ids = interest_ids
    end

    def call
      user = yield find_user(user_id)
      interests = yield fetch_intersts(interest_ids)
      user = yield update_user_interests(user, interests)

      Success(OpenStruct.new({ user: user, interests: interests }))
    end

    private

    attr_reader :user_id, :interest_ids

    def update_user_interests(user, interests)
      user.interests = interests

      Success(user)
    end

    def fetch_intersts(interest_ids)
      interests = Interest.where(id: Array(interest_ids))

      Success(interests)
    end
  end
end
