# frozen_string_literal: true

module Api
  # Welcome to the User
  class WelcomeController < ApplicationController
    def index
      render json: { error: false, message: 'Hello, World!' }
    end
  end
end
