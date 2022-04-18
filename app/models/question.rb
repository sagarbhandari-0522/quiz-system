class Question < ApplicationRecord
  has_many :question_categories
  has_many :categories, through: :question_categories
  has_many :options
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
end
