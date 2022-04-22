class Option < ApplicationRecord
  belongs_to :question
  validates :title, presence: true
  scope :correct, lambda { |id|
    where(question_id: id, correct: 'true')
  }
end
