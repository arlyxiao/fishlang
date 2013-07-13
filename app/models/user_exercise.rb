class UserExercise < ActiveRecord::Base
  attr_accessible :user, :exam, :error_count, :done_count, :done_exam

  attr_accessor :result

  belongs_to :user

  validates :user, :presence => true

  after_create :init_value

  def init_value
    self.error_count = 0
    self.done_count = 0
    self.done_exam = nil
    self.save
    reload
    self
  end

  def has_finished?
    done_exam == exam
  end

  def refresh(sentence)
    return self if sentence.done_exam?(self)

    sentence.move_done(self)

    sentence.user_failure(user).refresh unless result
    self.error_count = self.error_count + 1 unless result

    self.done_count = self.done_count + 1
    self.save

    self
  end


  def points
    return 1 if self.error_count == 1
    return 10 if self.error_count == 0
    0
  end

  def save_points(source)
    return if source.nil?
    source.user_points(user).refresh(self)
  end


  def sentence_ids
    return [] if exam.blank?
    JSON.parse(exam)
  end



  module UserMethods
    def self.included(base)
      base.has_one :exercise, :class_name => 'UserExercise', :foreign_key => :user_id
    end

    def build_exercise(source)
      if self.exercise.nil?
        UserExercise.create(:user => self, :exam => source.generate_exam)
        reload
      end

      exercise.init_value
    end
  end

end