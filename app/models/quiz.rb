class Quiz < ApplicationRecord
  has_many :question_quizzes
  has_many :questions, through: :question_quizzes
  has_and_belongs_to_many :categories

end
