# frozen_string_literal: true

module Api
  module V1
    # API Base Controller
    class ApiController < ApplicationController
      include ActionController::Serialization

      attr_reader :current_user

      before_action :authenticate_request

      private

      def authenticate_request
        auth_req = AuthServices::AuthorizeApiRequest.call(request.headers)

        if auth_req.success?
          @current_user = auth_req.success.user
        else
          render json: { error: true, message: auth_req.failure.message }, status: auth_req.failure.code
        end
      end
    end
  end
end
