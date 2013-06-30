class ExamPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam

  belongs_to :user
  belongs_to :practice

  validates :user, :practice, :exam, :presence => true


end