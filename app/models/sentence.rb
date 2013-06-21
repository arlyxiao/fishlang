class Sentence < ActiveRecord::Base
  attr_accessible :subject

  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

  validates :subject, :presence => true

  def translate?(subject)
    translations.map(&:subject).include? subject
  end
end