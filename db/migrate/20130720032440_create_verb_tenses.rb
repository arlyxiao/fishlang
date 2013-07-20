class CreateVerbTenses < ActiveRecord::Migration

  def change
    create_table :verb_tenses do |t|
      t.string   :name
      t.integer  :lesson_id
      t.string   :yo
      t.string   :tu
      t.string   :el
      t.string   :ella
      t.string   :usted
      t.string   :nosotros
      t.string   :nosotras
      t.string   :vosotros
      t.string   :vosotras
      t.string   :ellos
      t.string   :ellas
      t.string   :ustedes
      
      t.timestamps
    end
  end

end
