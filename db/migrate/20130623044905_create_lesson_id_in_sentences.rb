class CreateLessonIdInSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :lesson_id, :integer
  end
end
