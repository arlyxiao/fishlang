class SentenceFailurePoint < ActiveRecord::Base
  attr_accessible :user, :points

  belongs_to :user

  validates :user, :points, :presence => true


  module SentenceFailureMethods

    def user_points(user)
      unless SentenceFailurePoint.where(:user_id => user.id).exists?
        SentenceFailurePoint.create(:user => user)
      end
      
      SentenceFailurePoint.where(:user_id => user.id).first
    end
  end

end