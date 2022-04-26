# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  before_action :find_category, only: %i[show edit update destroy]
  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      flash[:success] = 'Category Created Successfully'
      redirect_to category_path(@category)
    else
      flash[:danger] = 'Category Created Unsuccessfull'
      render :new, status: :unprocessable_entity
    end
  rescue StandardError => e
    render body: e.message
  end

  def edit
    authorize @category
  end

  def update
    authorize @category
    if Category.update(category_params)
      redirect_to category_path(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  rescue StandardError => e
    render body: e.message
  end

  def destroy
    authorize @category
    @category.destroy
    redirect_to categories_path, status: :see_other
  rescue StandardError => e
    render body: e.message
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find_by_id(params[:id])
  end
end
