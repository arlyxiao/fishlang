class AddDefaultToErrorCount < ActiveRecord::Migration
  def change
    change_column :user_practices, :error_count, :integer, :default => 0
  end
end
