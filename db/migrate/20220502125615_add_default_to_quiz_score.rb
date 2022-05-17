class AddDefaultToQuizScore < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quizzes, :score, 0
  end
end
