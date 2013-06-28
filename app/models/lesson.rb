class Lesson < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :category
  has_many :practices

  validates :category, :name, :presence => true


end