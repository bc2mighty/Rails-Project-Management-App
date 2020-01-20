class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :read_access, :write_access, :update_access, :delete_access, :user_id, presence: true
end
