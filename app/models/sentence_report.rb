class SentenceReport < ActiveRecord::Base
  attr_accessible :sentence, :user, :user_answer, :content

  belongs_to :sentence
  belongs_to :user

  validates :sentence, :user, :content, :presence => true

  module UserMethods
    def self.included(base)
      base.has_many :sentence_reports
    end
	end

end