class Attachment < ApplicationRecord
  belongs_to :project
  has_many_attached :files
  validates_presence_of :title, :userid, :project_id
end
