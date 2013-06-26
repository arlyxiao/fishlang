class Verb < ActiveRecord::Base
  attr_accessible :practice, :name

  belongs_to :practice

  validates :practice, :name, :presence => true

end