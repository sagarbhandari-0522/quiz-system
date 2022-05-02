class QuizzesController < ApplicationController
  def index; end

  def select_category; end

  def new
    @quiz = Quiz.new
    @questions = QuestionCategory.where(category_id: params[:category_ids].drop(1)).sample(5)
  end

  def show
    @quiz = Quiz.find_by_id(params[:id])
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    @quiz.user_answer = @quiz.user_answer.filter { |a| !a.empty? }
    @quiz.question_ids = quiz_params[:question_ids].split(' ')
    @quiz.user_answer.each do |option_id|
      @quiz.score += 1 if Option.find(option_id).correct?
    end
    @quiz.percentage = @quiz.score * 10
    byebug
    @quiz.save
    redirect_to quiz_path(@quiz)
  end

  private

  def quiz_params
    params.require(:quiz).permit(:question_ids, user_answer: [])
  end
end
