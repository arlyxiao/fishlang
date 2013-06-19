class CreateSentenceTranslations < ActiveRecord::Migration
  def change
    create_table :sentence_translations do |t|
      t.string   :content
      
      t.timestamps
    end
  end
end
