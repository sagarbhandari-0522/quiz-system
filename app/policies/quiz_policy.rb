# frozen_string_literal: true

class QuizPolicy < ApplicationPolicy
  attr_reader :user, :quiz

  def initialize(user, quiz)
    @user = user
    @quiz = quiz
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    true
  end

  def show?
    @user.admin? || @quiz.user == @user
  end

  def new?
    @user
  end

  def create?
    new?
  end

  def destroy?
    show?
  end
end
