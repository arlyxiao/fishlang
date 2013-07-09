class CreateSentenceReports < ActiveRecord::Migration

  def change
    create_table :sentence_reports do |t|
      t.integer  :sentence_id
      t.integer  :user_id
      t.string   :choice
      t.text     :content
      
      t.timestamps
    end
  end

end
