class AddVerbInSentences < ActiveRecord::Migration
  def change
    add_column :sentences, :verb, :string
  end
end
