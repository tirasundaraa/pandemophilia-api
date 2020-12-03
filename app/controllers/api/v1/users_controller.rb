# frozen_string_literal: true

# API v1
module Api
  module V1
    # UsersController
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: [:create]

      def index
        @users = User.order(id: :desc)

        render json: @users
      end

      def show
        show_user = UserServices::ShowUser.call(params[:id])

        if show_user.success?
          render json: show_user.success.user
        else
          render json: { error: true, message: show_user.failure.message }, status: show_user.failure.code
        end
      end

      def create
        registration = UserServices::CreateUser.call(user_params)

        if registration.success?
          render json: registration.success.user, auth_token: registration.success.auth_token
        else
          render json: { error: true, message: registration.failure.message }, status: registration.failure.code
        end
      end

      def update
        user_update = UserServices::UpdateUser.call(params[:id], user_params)

        if user_update.success?
          render json: user_update.success.user
        else
          render json: { error: true, message: user_update.failure.message }, status: user_update.failure.code
        end
      end

      private

      def user_params
        params.require(:user).permit(UserServices::Common::PERMITED_PARAMS)
      end
    end
  end
end
