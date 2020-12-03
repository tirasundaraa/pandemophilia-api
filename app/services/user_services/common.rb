# frozen_string_literal: true

module UserServices
  module Common
    PERMITED_PARAMS = %i[first_name last_name email phone_number bio password password_confirmation].freeze

    include Dry::Monads[:result]

    private

    def find_user(id)
      user = User.find_by(id: id)

      if user
        Success(user)
      else
        Failure(OpenStruct.new({ code: 404, message: :user_not_found }))
      end
    end
  end
end
