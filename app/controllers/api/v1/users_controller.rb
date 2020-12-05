# frozen_string_literal: true

# API v1
module Api
  module V1
    # UsersController
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: [:create]

      def index
        @users = UserQuery.call(params, includes: :interests, exclude_ids: current_user.id)

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
        user_update = UserServices::UpdateUser.call(current_user.id, user_params)

        if user_update.success?
          render json: user_update.success.user
        else
          render json: { error: true, message: user_update.failure.message }, status: user_update.failure.code
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        render json: { error: false, message: 'delete success' }

      rescue ActiveRecord::RecordNotFound => e
        render json: { error: true, message: e.message }, status: 404
      end

      def my_profile
        render json: current_user
      end

      def toggle_pandemophilia
        toggle_pandemophilia = UserServices::TogglePandemophilia.call(current_user.id)

        if toggle_pandemophilia.success?
          render json: toggle_pandemophilia.success.user
        else
          render json: { error: true, message: toggle_pandemophilia.failure.message }, status: toggle_pandemophilia.failure.code
        end
      end

      def interests
        result = UserServices::AddUserInterests.call(current_user.id, user_interests_params)

        if result.success?
          render json: result.success.user
        else
          render json: { error: true, message: result.failure.message }, status: result.failure.code
        end
      end

      private

      def user_interests_params
        params.require(:user).permit(:question, :answer, interest_ids: [])
      end

      def user_params
        params.require(:user).permit(UserServices::Common::PERMITED_PARAMS)
      end
    end
  end
end
