class UserPracticePoint < ActiveRecord::Base
  attr_accessible :user, :practice, :number

  belongs_to :user
  belongs_to :practice

  validates :user, :practice, :number, :presence => true

  def set_full_number
    self.number = self.number + 10
    self.save
  end

  def set_junior_number
    self.number = self.number + 1
    self.save
  end

  module UserMethods

    def self.included(base)
      base.has_many :practice_points, :class_name => 'UserPracticePoint', :foreign_key => :user_id
    end

    def get_practice_point(practice)
      practice_points.where(:practice_id => practice.id).first
    end

  end

end