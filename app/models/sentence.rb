class Sentence < ActiveRecord::Base
  attr_accessible :practice, :subject, :verb

  belongs_to :practice
  has_many :translations, 
           :class_name => 'SentenceTranslation', 
           :foreign_key => :sentence_id,
           :dependent => :destroy

  validates :practice, :subject, :verb, :presence => true

  def next_id_by(user)
    user_practice = user.get_practice(practice)
    return nil unless self.is_in_exam?(user_practice)

    ids = user.get_sentence_ids(practice)
    if ids.last == self.id
      user.get_practice(practice).disable
      return nil
    end

    ids[ids.index(self.id) + 1]
  end

  def translate?(subject)
    subjects = translations.map!{|c| c.subject.downcase.strip.squeeze(' ')}
    subjects.include? subject.downcase.strip.squeeze(' ')
  end

  def move_done_in(user_practice)
    ids = [] if user_practice.done_exam.blank?
    ids = JSON.parse(user_practice.done_exam) unless user_practice.done_exam.blank?

    ids << self.id
    user_practice.done_exam = ids.to_json
    user_practice.save
  end

  def done_exam_in?(user_practice)
    ids = [] if user_practice.done_exam.blank?
    ids = JSON.parse(user_practice.done_exam) unless user_practice.done_exam.blank?

    ids.include? self.id
  end

  def is_in_exam?(user_practice)
    ids = JSON.parse(user_practice.exam) unless user_practice.exam.blank?

    ids.include? self.id
  end
  
end