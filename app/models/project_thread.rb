class ProjectThread < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :topic, :description, presence: true, length: {minimum: 5}
end
