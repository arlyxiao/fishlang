class AddVerbTenseIdIntoSentences < ActiveRecord::Migration
  def up
    add_column :sentences, :verb_tense_id, :integer, :null => false, :default => 0
  end
end
