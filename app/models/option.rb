class Option < ApplicationRecord
  belongs_to :question
  has_one_attached :image
  #  scope :correct, ->(id) { where("question_id==#{id}" && 'correct ==true') }
  scope :correct, lambda { |id|
    where(question_id: id, correct: 'true')
  }
end
