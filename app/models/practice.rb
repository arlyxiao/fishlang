class Practice < ActiveRecord::Base
  attr_accessible :lesson, :name

  belongs_to :lesson
  has_many :sentences, :dependent => :destroy

  validates :lesson, :name, :presence => true

  def exam_sentences
    sentences.sample(10)
  end

  def exam_practice_of_user(user)
    user.exam_practice(self) if user.has_exam_practice?
  end


end