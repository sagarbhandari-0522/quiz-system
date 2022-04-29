# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[show edit update destroy]
  def index
    @questions = Question.all
  rescue StandardError => e
    render body: e.message
  end

  def new
    @question = Question.new
    @question.options.build
    authorize @question
  end

  def show
    @option = Option.correct(@question)
    authorize @question
  rescue StandardError => e
    render body: e.message
  end

  def create
    @question = Question.new(question_params)
    authorize @question
    if @question.save
      redirect_to question_path(@question)
    else
      render :new, status: :unprocessable_entity
    end
  rescue StandardError => e
    render body: e.message
  end

  def edit
    authorize @question
  end

  def update
    authorize @question
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit, status: :unprocessable_entity
    end
  rescue StandardError => e
    render body: e.message
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to questions_path, status: :see_other
  rescue StandardError => e
    render body: e.message
  end

  private

  def question_params
    params.require(:question).permit(:title, category_ids: [],
                                             options_attributes: %i[id title correct image _destroy])
  end

  def find_question
    @question = Question.find_by_id(params[:id])
  end
end
