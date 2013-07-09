class SentenceTranslation < ActiveRecord::Base
  attr_accessible :sentence, :user, :choice, :content

  belongs_to :sentence
  belongs_to :user

  validates :sentence, :user, :choice, :content, :presence => true
end