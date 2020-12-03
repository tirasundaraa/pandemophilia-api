# frozen_string_literal: true

module Api
  module V1
    # API Base Controller
    class ApiController < ApplicationController
      before_action :authenticate_request

      private

      def authenticate_request
        render json: { error: true, message: 'Not authorized' }, status: 401 unless current_user
      end

      def current_user
        @current_user ||= AuthorizeApiRequest.call(request.headers)
      end
    end
  end
end
