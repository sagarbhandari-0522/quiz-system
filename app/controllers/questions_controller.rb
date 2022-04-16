class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show edit update destroy]
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show; end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, status: :see_other
  end

  private

  def question_params
    params.require(:question).permit(:title)
  end

  def find_question
    @question = Question.find_by_id(params[:id])
  end
end