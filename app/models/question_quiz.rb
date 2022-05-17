# frozen_string_literal: true

class QuestionQuiz < ApplicationRecord
  belongs_to :question
  belongs_to :quiz
end
