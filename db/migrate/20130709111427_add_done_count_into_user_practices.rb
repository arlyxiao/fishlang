class AddDoneCountIntoUserPractices < ActiveRecord::Migration
  def up
  	add_column :user_practices, :done_count, :integer, :default => 0
  end

end
