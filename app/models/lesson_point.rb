class LessonPoint < ActiveRecord::Base
  attr_accessible :user, :lesson, :points

  belongs_to :user
  belongs_to :lesson

  validates :user, :lesson, :points, :presence => true


  module LessonMethods
    def self.included(base)
      base.has_many :points, :class_name => 'LessonPoint', :foreign_key => :lesson_id
    end

    def user_points(user)
      points.where(:user_id => user.id).first_or_create
    end
  end

end