# frozen_string_literal: true

class User < ApplicationRecord
  scope :pandemophilia, -> () { where(is_pandemophilia: true) }
  scope :not_pandemophilia, -> () { where(is_pandemophilia: [false, nil]) }

  has_secure_password
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  validates_presence_of :first_name
  validates_uniqueness_of :email, :phone_number
  validates_length_of :password, in: 8..32, allow_blank: true
end
