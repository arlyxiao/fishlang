class SentenceFailure < ActiveRecord::Base
  attr_accessible :user, :sentence, :count

  belongs_to :user
  belongs_to :sentence

  validates :user, :sentence, :count, :presence => true


  def refresh
  	self.count = self.count + 1
  	self.save
  end


  module SentenceMethods
    def self.included(base)
      base.has_many :failures, :class_name => 'SentenceFailure', :foreign_key => :sentence_id
    end

    def user_failure(user)
    	rows = failures.where(:user_id => user.id)
    	return rows.first if rows.exists?
    	failures.create(:user => user)
    end
  end

end