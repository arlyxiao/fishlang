class SentenceFailure < ActiveRecord::Base
  attr_accessible :user, :sentence, :count

  belongs_to :user
  belongs_to :sentence

  validates :user, :sentence, :count, :presence => true


  module SentenceMethods
    def self.included(base)
      base.has_many :failures, :class_name => 'SentenceFailure', :foreign_key => :sentence_id
    end

    def user_failure(user)
      failures.where(:user_id => user.id).first
    end
  end

end