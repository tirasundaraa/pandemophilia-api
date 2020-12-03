# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/welcome#index'

  scope module: :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: %i[index create show update]
      resources :authentication, only: %i[create destroy]
    end
  end
end
