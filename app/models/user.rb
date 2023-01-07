# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :userid, :fullname, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 5 }, on: :create
end
