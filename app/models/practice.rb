class Practice < ActiveRecord::Base
  attr_accessible :lesson, :name

  belongs_to :lesson
  has_many :sentences, :dependent => :destroy

  validates :lesson, :name, :presence => true

end