class AddCorrectCountIntoSentenceFailures < ActiveRecord::Migration
  def up
  	add_column :sentence_failures, :correct_count, :integer, :null => false, :default => 0
  end
end
