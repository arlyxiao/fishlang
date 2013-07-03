class AddIntoUserPractices < ActiveRecord::Migration
  def change
    add_column :user_practices, :error_count, :integer
    add_column :user_practices, :has_finished, :boolean, :default => false
  end
end
