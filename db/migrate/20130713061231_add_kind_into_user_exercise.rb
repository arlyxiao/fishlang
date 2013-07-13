class AddKindIntoUserExercise < ActiveRecord::Migration
  def change
  	add_column :user_exercises, :kind, :string
  end
end
