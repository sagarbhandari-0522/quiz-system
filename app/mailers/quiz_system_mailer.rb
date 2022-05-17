# frozen_string_literal: true

class QuizSystemMailer < ApplicationMailer
  default from: 'sagarvandari@gmail.com'
  def welcome_email
    @email = params[:email]
    report = params[:report]
    attachments['QUIZ.pdf'] = report
    mail(to: @email, subject: 'Welcome to Quiz System')
  end
end
