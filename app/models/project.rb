class Project < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5}
  validates :user_id, :description, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 10}
end
