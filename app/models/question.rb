# frozen_string_literal: true

class MyValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:options, 'You must have at least three options') if record.options.length < 3
  end
end

class Question < ApplicationRecord
  include ActiveModel::Validations
  has_many :question_categories
  has_many :categories, through: :question_categories
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true
  validates_with MyValidator
end
