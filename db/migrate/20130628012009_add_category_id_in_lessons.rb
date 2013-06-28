class AddCategoryIdInLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :category_id, :integer
  end
end
