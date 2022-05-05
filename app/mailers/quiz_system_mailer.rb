class QuizSystemMailer < ApplicationMailer
  default from: 'sagarvandari@gmail.com'
  def welcome_email
    @user = params[:user]
    @url = 'https://example.com/login'
    @quiz = params[:quiz]
    @questions = params[:question]
    pdf1 = QuizzesController.new.render_to_string(
      layout: 'pdf',
      template: 'quizzes/pdf',
      locals: { :@quiz => @quiz,
                :@questions => @questions }
    )
    pdf = Grover.new(pdf1).to_pdf
    attachments['image.pdf'] = pdf
    mail(to: @user.email, subject: 'Welcome to Quiz System')
  end
end
