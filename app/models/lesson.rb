class Lesson < ActiveRecord::Base
  attr_accessible :name

  has_many :practices

  validates :name, :presence => true

end