class Project < ApplicationRecord
  belongs_to :user
  has_many :attachments, :dependent => :destroy
  validates :title, presence: true, length: {minimum: 5}
  validates :user_id, :description, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 10}
end
