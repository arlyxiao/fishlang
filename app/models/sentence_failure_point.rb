class SentenceFailurePoint < ActiveRecord::Base
  attr_accessible :user, :points

  belongs_to :user

  validates :user, :points, :presence => true


  module SentenceFailureMethods

    def user_points(user)
      SentenceFailurePoint.where(:user_id => user.id).first_or_create
    end

  end

end