class RenameColumnPercentage < ActiveRecord::Migration[7.0]
  def change
    rename_column :quizzes, :perentage, :percentage
  end
end
