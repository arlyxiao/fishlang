class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.integer  :practice_id
      t.string   :name
      
      t.timestamps
    end

  end
end
