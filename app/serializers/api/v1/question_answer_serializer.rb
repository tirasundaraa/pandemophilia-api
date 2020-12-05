# frozen_string_literal: true

module Api
  module V1
    class QuestionAnswerSerializer < ActiveModel::Serializer
      attributes :id, :question, :answer
    end
  end
end
