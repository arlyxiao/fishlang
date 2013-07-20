class VerbTense < ActiveRecord::Base
  attr_accessible :lesson_id, :name, :yo, :tu, :el, :ella, :usted,
                  :nosotros, :nosotras, :vosotros, :vosotras, :ellos, :ellas, :ustedes

  belongs_to :lesson

  #validates :name, :uniqueness => {:scope => :lesson_id}


end