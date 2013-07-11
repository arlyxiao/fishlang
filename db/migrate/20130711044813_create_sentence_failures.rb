class CreateSentenceFailures < ActiveRecord::Migration
  def change
  	create_table :sentence_failures do |t|
      t.integer  :sentence_id
      t.integer  :user_id
      t.integer  :count, :null => false, :default => 0
      
      t.timestamps
    end

  end
end
