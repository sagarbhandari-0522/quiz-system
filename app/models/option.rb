# frozen_string_literal: true

class Option < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 1.megabytes }
  belongs_to :question
  validates :title, presence: true
  scope :correct, lambda { |id|
    where(question_id: id, correct: 'true')
  }
end
