class AddSentenceId < ActiveRecord::Migration
  def change
    add_column :sentence_translations, :sentence_id, :integer
  end
end
