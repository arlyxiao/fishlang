class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :lessons

  validates :name, :presence => true

end