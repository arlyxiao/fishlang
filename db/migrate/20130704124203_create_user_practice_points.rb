class CreateUserPracticePoints < ActiveRecord::Migration
  def change
    create_table :user_practice_points do |t|
      t.integer   :user_id
      t.integer   :practice_id
      t.integer   :number
      
      t.timestamps
    end
  end
end
