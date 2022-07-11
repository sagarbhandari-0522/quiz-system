# frozen_string_literal: true

class Quiz < ApplicationRecord
  has_noticed_notifications
  has_many :question_quizzes, dependent: :destroy
  has_many :questions, through: :question_quizzes
  has_and_belongs_to_many :categories
  scope :filter_quiz, -> { where.not(user_answer: []) }
  belongs_to :user, optional: true
  after_update_commit :notify_receipt
  before_update :calculation

  before_destroy :cleanup_notifications

  def notify_receipt
    QuizNotification.with(quiz: self, email: user.email).deliver_later(User.all.admin) unless user.nil?
    QuizNotification.with(quiz: self, email: email).deliver_later(User.all.admin) if user.nil?
  end

  def cleanup_notifications
    notifications_as_quiz.destroy_all
  end

  def self.find_user
    users = []
    Quiz.all.find_each do |quiz|
      users << quiz.user unless quiz.user.nil?
    end
    users.uniq
  end

  def score(answers)
    scores = 0
    answers.each do |option_id|
      scores += 1 if Option.find(option_id).correct
    end
    scores
  end

  def percentage(score)
    (score * 100) / questions.count
  end
end
