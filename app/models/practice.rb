class Practice < ActiveRecord::Base
  attr_accessible :lesson, :name

  belongs_to :lesson
  has_many :sentences, :dependent => :destroy

  validates :lesson, :name, :presence => true

  def generate_exam
    sentences.sample(10).map(&:id).to_json
  end


end