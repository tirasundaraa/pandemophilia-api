# frozen_string_literal: true

module Api
  module V1
    # Manage login / logout
    class AuthenticationController < ApiController
      skip_before_action :authenticate_request, only: [:create]

      def create
        auth = AuthServices::AuthenticateUser.call(auth_params)

        if auth.success?
          render json: { auth_token: auth.success.token }
        else
          render json: { error: true, message: auth.failure.message }, status: auth.failure.code
        end
      end

      private

      def auth_params
        params.require(:authentication).permit(:email, :password)
      end
    end
  end
end
