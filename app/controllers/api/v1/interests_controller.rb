# frozen_string_literal: true

# API v1
module Api
  module V1
    # UsersController
    class InterestsController < ApiController

      def index
        @interests = InterestQuery.call(params)

        render json: @interests
      end
    end
  end
end
