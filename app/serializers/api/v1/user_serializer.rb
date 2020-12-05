# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, 
                 :email, :phone_number, :bio,
                 :is_pandemophilia, :avatar_url

      attribute :auth_token, if: :auth_token?

      has_many :interests
      has_one :question_answer

      def auth_token
        instance_options[:auth_token]
      end

      def auth_token?
        !!instance_options[:auth_token]
      end
    end
  end
end
