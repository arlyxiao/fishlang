class CreateUserPractices < ActiveRecord::Migration
  def change
    create_table :user_practices do |t|
      t.integer   :user_id
      t.integer   :practice_id
      t.string      :exam
      
      t.timestamps
    end
  end
end
