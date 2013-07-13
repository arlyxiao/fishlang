class Lesson < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :category
  has_many :practices

  validates :category, :name, :presence => true


  def generate_exam
  	ids = []
  	practices.each do |p|
  		p.sentences.each do |s|
  			ids << s.id
  		end
  	end
  	
    ids.sample(10).to_json
  end


  include LessonPoint::LessonMethods

end