class AddDefaultZeroToQuizScore < ActiveRecord::Migration[7.0]
  def change
    change_column :quizzes, :score, :integer, defalut: 0
  end
end
