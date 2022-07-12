# frozen_string_literal: true

module QuizzesHelper
  def quiz_categories(quiz)
    name = quiz.categories.map(&:name)
    name.join(',')
  end

  def show_pagy(obj)
    obj.count > 5
  end

  def option?(option)
    option.instance_of?(Option)
  end

  def correct?(option)
    option.correct
  end

  def quiz_email(quiz)
    quiz.email || quiz.user.email
  end
end
