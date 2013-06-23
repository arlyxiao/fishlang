class Sentence < ActiveRecord::Base
  attr_accessible :lesson, :subject

  belongs_to :lesson
  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

  validates :lesson, :subject, :presence => true

  scope :by_lesson, lambda{|lesson| {:conditions => ['lesson_id = ?', lesson.id]} }

  def next_id
    self.class.by_lesson(self.lesson).where('id > ?', self.id).first.id
  end

  def translate?(subject)
    subjects = translations.map!{|c| c.subject.downcase.strip.squeeze(' ')}
    subjects.include? subject.downcase.strip.squeeze(' ')
  end
end