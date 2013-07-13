class SentenceFailure < ActiveRecord::Base
  attr_accessible :user, :sentence, :count, :correct_count

  belongs_to :user
  belongs_to :sentence

  validates :user, :sentence, :count, :presence => true

  default_scope :order => "count DESC"

  scope :by_count, :conditions => ['correct_count < count * 3']


  def refresh(result)
    return if result && count == 0
  	self.count = self.count + 1 unless result
    self.correct_count = self.correct_count + 1 if result
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

  module UserMethods
    def self.included(base)
      base.has_many :sentence_failures
    end
  end

end