class QuizSystemMailer < ApplicationMailer
  default from: 'sagarvandari@gmail.com'
  def welcome_email
    @user = params[:user]
    report = params[:report]
    attachments['QUIZ.pdf'] = report
    mail(to: @user.email, subject: 'Welcome to Quiz System')
  end
end
