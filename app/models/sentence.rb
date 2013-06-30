class Sentence < ActiveRecord::Base
  attr_accessible :practice, :subject, :verb

  belongs_to :practice
  has_many :translations, 
           :class_name => 'SentenceTranslation', 
           :foreign_key => :sentence_id,
           :dependent => :destroy

  validates :practice, :subject, :verb, :presence => true

  scope :by_practice, lambda{|practice| {:conditions => ['practice_id = ?', practice.id]} }

  def next_id_by(user)
    sentences = user.get_practice(practice)
    return nil if sentences.last == self

    ids = sentences.map(&:id)
    ids.each_with_index { |val, index| return ids[index + 1] if self.id == val }
  end

  def translate?(subject)
    subjects = translations.map!{|c| c.subject.downcase.strip.squeeze(' ')}
    subjects.include? subject.downcase.strip.squeeze(' ')
  end
end