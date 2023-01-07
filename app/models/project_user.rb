# frozen_string_literal: true

class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :messages
  validates :user_id, presence: true
end
