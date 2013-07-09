class SentenceReport < ActiveRecord::Base
  attr_accessible :sentence, :user, :user_answer, :content

  belongs_to :sentence
  belongs_to :user

  validates :sentence, :user, :content, :presence => true
end