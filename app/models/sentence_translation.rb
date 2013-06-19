class SentenceTranslation < ActiveRecord::Base
  belongs_to :sentence

  validates :sentence, :content, :presence => true
end