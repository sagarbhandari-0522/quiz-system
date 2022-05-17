# frozen_string_literal: true

module QuizzesHelper
  def quiz_categories(quiz)
    name = quiz.categories.map(&:name)
    name.join(',')
  end
end
