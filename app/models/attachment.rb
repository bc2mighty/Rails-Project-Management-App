# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :project
  has_many_attached :files
  validates :title, :userid, :project_id, presence: true
end
