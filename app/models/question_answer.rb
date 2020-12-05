# frozen_string_literal: true

class QuestionAnswer < ApplicationRecord
  belongs_to :user

  validates_presence_of :question, :answer
end
