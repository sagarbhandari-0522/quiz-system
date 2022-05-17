class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :user_answer, array: true, default: []
      t.integer :score
      t.numeric :perentage
      t.text :report

      t.timestamps
    end
  end
end
