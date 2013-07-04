class UserPracticePoint < ActiveRecord::Base
  attr_accessible :user, :practice, :number

  belongs_to :user
  belongs_to :practice

  validates :user, :practice, :number, :presence => true
end