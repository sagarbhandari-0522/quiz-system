class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz, only: %i[show destroy]
  def index
    @quizzes = if current_user.admin?
                 Quiz.all
               else
                 current_user.quizzes
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

    # pdf = grover.to_pdf
    respond_to do |format|
      format.html

      format.pdf do
        QuizSystemMailer.with(user: current_user, quiz: @quiz, question: @questions).welcome_email.deliver_now
        flash[:success] = 'Mail sent successfully'
        pdf1 = QuizzesController.new.render_to_string(
          layout: 'pdf',
          template: 'quizzes/pdf',
          locals: { :@quiz => @quiz,
                    :@questions => @questions }
        )
        pdf = Grover.new(pdf1).to_pdf
        send_data(pdf, filename: 'your_filename.pdf', type: 'application/pdf')
      end
    end
    mark_notifications_as_read
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    authorize @quiz
    @quiz.user_answer = @quiz.user_answer.filter { |a| !a.empty? }
    @quiz.question_ids = quiz_params[:question_ids][0].split
    @quiz.category_ids = quiz_params[:category_ids][0].split
    @quiz.score = score(@quiz.user_answer)
    @quiz.percentage = percentage(@quiz.score)
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

  def mark_notifications_as_read
    notifications_to_mark_as_read = @quiz.notifications_as_quiz.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

  def score(answer)
    scores = 0
    answer.each do |option_id|
      scores += 1 if Option.find(option_id).correct
    end
    scores
  end

  def percentage(score)
    score / 5 * 100
  end
end
