# frozen_string_literal: true

module Api
  module V1
    # Manage login / logout
    class AuthenticationController < ApiController
      skip_before_action :authenticate_request, only: [:create]

      def create
        auth = ::AuthenticateUser.new(email: auth_params[:email], password: auth_params[:password])

        if token_auth = auth.call
          render json: { token: token_auth }
        else
          render json: { error: true, message: 'wrong email and/or password' }, status: :unauthorized
        end
      end

      private

      def auth_params
        params.require(:authentication).permit(:email, :password)
      end
    end
  end
end
