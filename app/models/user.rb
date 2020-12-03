# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates_presence_of :first_name
  validates_uniqueness_of :email, :phone_number
  validates_length_of :password, in: 8..32
end
