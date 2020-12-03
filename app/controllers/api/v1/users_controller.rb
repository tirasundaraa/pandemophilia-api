# frozen_string_literal: true

# API v1
module Api
  module V1
    # UsersController
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: [:create]

      def index
        @users = User.all

        render json: @users
      end

      def create
        result = RegisterUser.call(user_params)

        if result.success?
          render json: result.user
        else
          render json: { error: true, message: result.message }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end
end
