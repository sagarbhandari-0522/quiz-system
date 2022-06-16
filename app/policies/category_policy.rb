# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :question

  def initialize(user, category)
    super
    @user = user
    @category = category
  end

  class Scope < Scope
    def resolve
      scope.all
    end
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
