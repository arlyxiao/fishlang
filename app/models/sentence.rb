class Sentence < ActiveRecord::Base
  attr_accessible :subject

  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

  validates :subject, :presence => true

  def translate?(subject)
    subjects = translations.map!{|c| c.subject.downcase.strip}
    subjects.include? subject.downcase.strip
  end
end