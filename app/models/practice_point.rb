class PracticePoint < ActiveRecord::Base
  attr_accessible :user, :practice, :points

  belongs_to :user
  belongs_to :practice

  validates :user, :practice, :points, :presence => true


  module PracticeMethods
    def self.included(base)
      base.has_many :points, :class_name => 'PracticePoint', :foreign_key => :practice_id
    end

    def user_points(user)
      points.where(:user_id => user.id).first_or_create
    end
  end

end