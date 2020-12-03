# frozen_string_literal: true

# User Registration service
class UpdateUser
  include Dry::Monads[:result, :do]

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

    Success(user)
  end

  private

  def update_user(user, params)
    if user.update(params)
      Success(user)
    else
      Failure(OpenStruct.new({ code: 422, message: user.errors.full_messages.join(",") }))
    end
  end

  def find_user(id)
    user = User.find_by(id: id)

    if user
      Success(user)
    else
      Failure(OpenStruct.new({ code: 404, message: :user_not_found }))
    end
  end
end
