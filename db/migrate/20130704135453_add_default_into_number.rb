class AddDefaultIntoNumber < ActiveRecord::Migration
  def change
    change_column :user_practice_points, :number, :integer, :default => 0
  end
end
