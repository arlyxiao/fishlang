class AddDoneExamIntoUserPractices < ActiveRecord::Migration
  def up
  	add_column :user_practices, :done_exam, :string
  end
end
