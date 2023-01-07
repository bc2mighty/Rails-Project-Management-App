# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :title, presence: true, length: { minimum: 1 }
end
