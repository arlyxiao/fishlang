class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam

  belongs_to :user
  belongs_to :practice

  validates :user, :practice, :exam, :presence => true


  module UserMethods
    def self.included(base)
      base.has_one :practice, :class_name => 'UserPractice', :foreign_key => :user_id
    end

    def has_practice?(practice)
      ExamPractice.where(:user_id => self.id, :practice_id => practice.id).exists?
    end

  end

end