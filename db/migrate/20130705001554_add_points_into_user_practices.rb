class AddPointsIntoUserPractices < ActiveRecord::Migration
  def change
    add_column :user_practices, :points, :integer, :default => 0
  end
end
