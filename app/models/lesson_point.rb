class LessonPoint < ActiveRecord::Base
  attr_accessible :user, :lesson, :points

  belongs_to :user
  belongs_to :lesson

  validates :user, :lesson, :points, :presence => true

  def refresh(user_exercise)
  	return unless user_exercise.has_finished?
  	self.points = self.points + user_exercise.points
  	self.save
  	reload
  	self
  end

  module LessonMethods
    def self.included(base)
      base.has_many :points, :class_name => 'LessonPoint', :foreign_key => :lesson_id
    end

    def user_points(user)
      points.create(:user => user) unless points.where(:user_id => user.id).exists?
      points.where(:user_id => user.id).first
    end
  end

end