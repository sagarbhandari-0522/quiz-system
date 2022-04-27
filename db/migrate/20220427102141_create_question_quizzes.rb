class CreateQuestionQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :question_quizzes do |t|
      t.belongs_to :question
      t.belongs_to :quiz
      t.timestamps
    end
  end
end
