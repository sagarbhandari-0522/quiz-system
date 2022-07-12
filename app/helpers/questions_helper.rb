# frozen_string_literal: true

module QuestionsHelper
  def question_categories(question)
    name = question.categories.map(&:name)
    name.join(' ')
  end
end
