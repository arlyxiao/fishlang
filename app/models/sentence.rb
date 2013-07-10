class Sentence < ActiveRecord::Base
  attr_accessible :practice, :subject, :verb

  belongs_to :practice
  has_many :translations, 
           :class_name => 'SentenceTranslation', 
           :foreign_key => :sentence_id,
           :dependent => :destroy

  validates :practice, :subject, :verb, :presence => true

  def next_id_by(user)
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
  
end