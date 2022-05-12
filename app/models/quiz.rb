# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_noticed_notifications
  has_many :question_quizzes
  has_many :questions, through: :question_quizzes
  has_and_belongs_to_many :categories
  belongs_to :user
  after_create_commit :notify_receipt
  def notify_receipt
    QuizNotification.with(quiz: self, user: user).deliver_later(User.all.admin)
  end
end
