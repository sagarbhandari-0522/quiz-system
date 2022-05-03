class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz, only: %i[show destroy]
  def index
    @quizzes = if current_user.admin?
                 Quiz.all
               else
                 Quiz.where(user_id: current_user.id)
               end
  rescue StandardError => e
    render body: e.message
  end

  def select_category; end

  def new
    @quiz = Quiz.new
    authorize @quiz
    @questions = QuestionCategory.where(category_id: params[:category_ids].drop(1)).uniq.sample(5)
    if @questions.count < 5
      flash[:danger] = "Your selected category dont have enough question \n Please Reselect "
      redirect_to play_quiz_path
    end
    @category = params[:category_ids]
  rescue StandardError => e
    render body: e.message
  end

  def show
    authorize @quiz
    @questions = QuestionQuiz.where(quiz_id: @quiz.id)
  rescue StandardError => e
    render body: e.message
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    authorize @quiz
    @quiz.user_answer = @quiz.user_answer.filter { |a| !a.empty? }
    @quiz.question_ids = quiz_params[:question_ids][0].split
    @quiz.category_ids = quiz_params[:category_ids][0].split
    @quiz.user_answer.each do |option_id|
      @quiz.score += 1 if Option.find(option_id).correct?
    end
    @quiz.percentage = @quiz.score * 10
    if @quiz.save
      flash[:success] = 'Thanks For Playing Quiz'
      redirect_to quiz_path(@quiz)
    else
      flash[:danger] = 'You have Missed Something REDO'
      render :select_category, status: :unprocessable_entity
    end
  rescue StandardError => e
    render body: e.message
  end

  def destroy
    authorize @quiz
    @quiz.destroy
    redirect_to quizzes_path, status: :see_other
  rescue StandardError => e
    render body: e.message
  end

  private

  def quiz_params
    params.require(:quiz).permit(question_ids: [], user_answer: [], category_ids: [])
  end

  def find_quiz
    @quiz = Quiz.find_by_id(params[:id])
  end
end
