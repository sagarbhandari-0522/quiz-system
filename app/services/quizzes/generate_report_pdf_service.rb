# frozen_string_literal: true

module Quizzes
  class GenerateReportPdfService
    def initialize(quiz:)
      @quiz = quiz
    end

    def execute
      generate_report_pdf
    end

    private

    def generate_report_pdf
      questions = @quiz.questions
      answers = @quiz.find_answer
      quiz_pdf = QuizzesController.new.render_to_string(
        layout: 'pdf',
        template: 'quizzes/pdf',
        locals: {
          :@quiz => @quiz,
          :@questions => questions,
          :@answers => answers
        }
      )
      Grover.new(quiz_pdf, display_url: 'https://sagar-quiz.herokuapp.com').to_pdf
    end
  end
end
