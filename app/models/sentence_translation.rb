class SentenceTranslation < ActiveRecord::Base
  attr_accessible :sentence, :subject

  belongs_to :sentence

  validates :sentence, :subject, :presence => true
end