class SentenceTranslation < ActiveRecord::Base
  belongs_to :sentence

  validates :sentence, :subject, :presence => true
end