class Option < ApplicationRecord
  belongs_to :question
  #  scope :correct, ->(id) { where("question_id==#{id}" && 'correct ==true') }
  scope :correct, lambda { |id|
    where(question_id: id, correct: 'true')
  }
end
