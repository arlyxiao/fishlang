class Practice < ActiveRecord::Base
  attr_accessible :lesson, :name

  belongs_to :lesson
  has_many :sentences
  has_many :verbs

  validates :lesson, :name, :presence => true

end