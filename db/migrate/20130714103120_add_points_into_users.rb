class AddPointsIntoUsers < ActiveRecord::Migration
  def up
  	add_column :users, :points, :integer, :null => false, :default => 0
  end
end
