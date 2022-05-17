class CreateJoinTableCategoryQuiz < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :quizzes do |t|
      t.index %i[category_id quiz_id]
      t.index %i[quiz_id category_id]
    end
  end
end
