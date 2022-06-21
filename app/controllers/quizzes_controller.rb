# frozen_string_literal: true

class QuizzesController < ApplicationController
  layout :resolve_layout
  before_action :find_quiz, only: %i[show update destroy]
  before_action :select_category, only: %i[new]
  def index
    quizzes = current_user.admin? ? Quiz.filter_quiz : current_user.quizzes.filter_quiz
    @q = quizzes.ransack(params[:q])
    @pagy, @quizzes = pagy(@q.result(distinct: true), items: 10)
    @search_for = 'email_or_user_email_cont'
    @placeholder = 'Search User Quiz'
    @users = find_user
  rescue StandardError => e
    render(body: e.message)
  end

  def select_category; end

  def new
    if params[:category_ids].length == 1
      flash[:error] = 'Please Select at least One Category'
      redirect_to(play_quiz_path)
    else
      @questions = []
      @questions.push(categories_question)
      created if @questions.flatten!
      @quiz
    end
  end

  def created
    @quiz = Quiz.new
    @quiz.email = params[:email] if current_user.nil?
    @quiz.user_id = current_user.id unless current_user.nil?
    @quiz.category_ids = params[:category_ids].drop(1)
    question_quiz(@quiz.id) if @quiz.save
  end

  def show
    @questions = @quiz.questions
    @answers = find_answer(@quiz)
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
      update_success
    else
      flash[:danger] = 'You have Missed Something REDO'
      render(:select_category, status: :unprocessable_entity)
    end
  end

  def destroy
    authorize(@quiz)
    @quiz.destroy!
    redirect_to(quizzes_path, status: :see_other)
  rescue StandardError => e
    render(body: e.message)
  end

  def user_quizzes
    @user = User.find_by(id: params[:user_id])
    @quiz = @user.quizzes.filter_quiz
    respond_to do |format|
      format.js
    end
  end

  private

  def find_answer(quiz)
    answers = []
    quiz.user_answer.each do |answer_id|
      answer = Option.find_by(id: answer_id)
      answers << answer if answer
    end
    answers
  end

  def generate_report_pdf(format_is)
    @questions = @quiz.questions
    @answers = find_answer(@quiz)
    quiz_pdf = QuizzesController.new.render_to_string(
      layout: 'pdf',
      template: 'quizzes/pdf',
      locals: {
        :@quiz => @quiz,
        :@questions => @questions,
        :@answers => @answers
      }
    )
    pdf = Grover.new(quiz_pdf, display_url: 'https://sagar-quiz.herokuapp.com').to_pdf
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
    params[:quiz].values
  end

  def mark_notifications_as_read
    notifications_to_mark_as_read = @quiz.notifications_as_quiz.where(recipient: current_user)
    notifications_to_mark_as_read.update!(read_at: Time.zone.now)
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
      QuestionQuiz.create!(quiz_id: quiz_id, question_id: question.id)
    end
  end

  def find_user
    users = []
    @quizzes.each do |quiz|
      users << quiz.user unless quiz.user.nil?
    end
    users.uniq
  end

  def categories_question
    Category.includes(:questions).find(params[:category_ids].drop(1)).map(&:questions).flatten!.uniq.sample(8)
  end

  def update_success
    @guest_email = @quiz.email || current_user.email
    send_email
    flash[:success] = 'Thanks For Playing Quiz'
    redirect_to(quiz_path(@quiz))
  end

  def send_email
    QuizSystemMailer.with(
      email: @guest_email,
      report: generate_report_pdf('mail')
    ).welcome_email.deliver_later
  end

  def resolve_layout
    if current_user
      'application'
    else
      'non-logged'
    end
  end
end
