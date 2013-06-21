class ChangeContentInTranslations < ActiveRecord::Migration
  def change
    rename_column :sentence_translations, :content, :subject
  end
end
