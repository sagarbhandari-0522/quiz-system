# frozen_string_literal: true

class Option < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :question
  validates :title, presence: true
  scope :correct, lambda { |id|
    where(question_id: id, correct: 'true')
  }
end
