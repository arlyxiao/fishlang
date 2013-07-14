class CreateSentenceFailurePoints < ActiveRecord::Migration
  def change
    create_table :sentence_failure_points do |t|
      t.integer   :user_id
      t.integer   :points, :null => false, :default => 0
      
      t.timestamps
    end
  end
end
