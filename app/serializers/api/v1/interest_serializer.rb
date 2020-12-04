# frozen_string_literal: true

module Api
  module V1
    class InterestSerializer < ActiveModel::Serializer
      attributes :id, :name

      def name
        object.name.humanize.titleize
      end
    end
  end
end
