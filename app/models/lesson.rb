class Lesson < ActiveRecord::Base
  attr_accessible :name

  has_many :sentences

  validates :name, :presence => true

end