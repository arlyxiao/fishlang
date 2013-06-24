class Practice < ActiveRecord::Base
  attr_accessible :name

  belongs_to :lesson
  has_many :sentences

  validates :name, :presence => true

end