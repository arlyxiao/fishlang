class CreateLessonPoints < ActiveRecord::Migration
  def change
    create_table :lesson_points do |t|
      t.integer   :user_id
      t.integer   :lesson_id
      t.integer   :points, :null => false, :default => 0
      
      t.timestamps
    end
  end
end
