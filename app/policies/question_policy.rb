# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def initialize(user, question)
    super
    @user = user
    @question = question
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
