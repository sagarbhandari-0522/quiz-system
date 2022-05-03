# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :question_categories, dependent: :destroy
  has_many :questions, through: :question_categories
  has_and_belongs_to_many :quizzes
  validates :name, presence: true
end
