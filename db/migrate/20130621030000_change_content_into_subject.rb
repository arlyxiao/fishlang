class ChangeContentIntoSubject < ActiveRecord::Migration
  def change
    rename_column :sentences, :content, :subject
  end
end
