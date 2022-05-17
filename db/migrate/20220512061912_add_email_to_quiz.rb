class AddEmailToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_column :quizzes, :email, :string
  end
end
