class ChangeLessonIdIntoPraticeId < ActiveRecord::Migration
  def change
    rename_column :sentences, :lesson_id, :practice_id
  end
end
