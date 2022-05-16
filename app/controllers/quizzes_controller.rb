# frozen_string_literal: true

class QuizzesController < ApplicationController
  before_action :find_quiz, only: %i[show update destroy]
  def index
    @quizzes = current_user.admin? ? Quiz.all : current_user.quizzes
  rescue StandardError => e
    render(body: e.message)
  end

  def select_category; end

  def new
    @questions = []
    @questions.push(categories_question)
    created if @questions.flatten!
    @quiz
  end

  def created
    @quiz = Quiz.new
    @quiz.category_ids = params[:category_ids].drop(1)
    question_quiz(@quiz.id) if @quiz.save
  end

  def show
    @questions = QuestionQuiz.where(quiz_id: @quiz.id)
    respond_to do |format|
      format.html
      format.pdf do
        generate_report_pdf('report_pdf')
      end
    end
    mark_notifications_as_read
  end

  def update
    user_answer = answer
    scores = score(user_answer)
    percentage = percentage(scores)
    if @quiz.update(user_answer: user_answer, percentage: percentage, score: scores)
      flash[:success] = 'Thanks For Playing Quiz'
      QuizSystemMailer.with(email: current_user.email, report: generate_report_pdf('mail')).welcome_email.deliver_later unless current_user.nil?
      QuizSystemMailer.with(email: @quiz.email, report: generate_report_pdf('mail')).welcome_email.deliver_later if current_user.nil?
      redirect_to(quiz_path(@quiz))
    else
      flash[:danger] = 'You have Missed Something REDO'
      render(:select_category, status: :unprocessable_entity)
    end
  rescue StandardError => e
    render(body: e.message)
  end

  def destroy
    authorize(@quiz)
    @quiz.destroy!
    redirect_to(quizzes_path, status: :see_other)
  rescue StandardError => e
    render(body: e.message)
  end

  private

  def quiz_params
    params.require(:quiz).permit(user_answer: [])
  end

  def generate_report_pdf(format_is)
    @questions = QuestionQuiz.where(quiz_id: @quiz.id)
    pdf1 = QuizzesController.new.render_to_string(
      layout: 'pdf',
      template: 'quizzes/pdf',
      locals: {
        :@quiz => @quiz,
        :@questions => @questions
      }
    )
    pdf = Grover.new(pdf1).to_pdf
    if format_is == 'report_pdf'
      send_data(pdf, filename: 'your_filename.pdf', type: 'application/pdf')
    else
      pdf
    end
  end

  def find_quiz
    @quiz = Quiz.find_by(id: params[:id])
  end

  def answer
    quiz_params[:user_answer].filter { |answer| !answer.empty? }
  end

  def mark_notifications_as_read
    notifications_to_mark_as_read = @quiz.notifications_as_quiz.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

  def score(answers)
    scores = 0
    answers.each do |option_id|
      scores += 1 if Option.find(option_id).correct
    end
    scores
  end

  def percentage(score)
    (score * 100) / @quiz.questions.count
  end

  def question_quiz(quiz_id)
    @questions.each do |question|
      QuestionQuiz.create(quiz_id: quiz_id, question_id: question.id)
    end
  end

  def categories_question
    Category.includes(:questions).find(params[:category_ids].drop(1)).map(&:questions).flatten!.uniq.sample(5)
  end
end
