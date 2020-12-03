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
        render json: user
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: true, message: e.message }, status: :not_found
      end

      def create
        registration = RegisterUser.call(user_params)

        if registration.success?
          render json: registration.success.user, auth_token: registration.success.auth_token
        else
          render json: { error: true, message: registration.failure.message }, status: registration.failure.code
        end
      end

      def update
        user_update = UpdateUser.call(params[:id], user_params)

        if user_update.success?
          render json: user_update.success
        else
          render json: { error: true, message: user_update.failure.message }, status: user_update.failure.code
        end
      end

      private

      def user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(RegisterUser::PERMITED_PARAMS)
      end
    end
  end
end
