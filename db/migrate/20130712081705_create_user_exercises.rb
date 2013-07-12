class CreateUserExercises < ActiveRecord::Migration
  def change
    create_table :user_exercises do |t|
      t.integer   :user_id
      t.string    :exam
      t.string    :done_exam
      t.integer   :error_count, :null => false, :default => 0
      t.integer   :done_count, :null => false, :default => 0
      
      t.timestamps
    end
  end
end
