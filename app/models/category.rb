class Category < ApplicationRecord
  has_many :question_categories, dependent: :delete_all
  has_many :questions, through: :question_categories
  validates :name, presence: true
end
