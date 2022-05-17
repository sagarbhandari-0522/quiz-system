# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_noticed_notifications
  has_many :question_quizzes
  has_many :questions, through: :question_quizzes
  has_and_belongs_to_many :categories
  belongs_to :user, optional: true
  after_create_commit :notify_receipt
  def notify_receipt
    QuizNotification.with(quiz: self, email: user.email).deliver_later(User.all.admin) unless user.nil?
    QuizNotification.with(quiz: self, email: email).deliver_later(User.all.admin) if user.nil?
  end
end
