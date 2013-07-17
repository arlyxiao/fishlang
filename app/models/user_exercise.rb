class UserExercise < ActiveRecord::Base
  attr_accessible :user, :exam, :error_count, :done_count, :done_exam, :kind

  attr_accessor :result

  belongs_to :user

  validates :user, :presence => true
  validates :user_id, :uniqueness => true

  after_create :init_value

  def init_value(source = nil)
    self.exam = source.generate_exam if source
    self.error_count = 0
    self.done_count = 0
    self.done_exam = nil
    self.kind = source.class.name.downcase
    self.save
    self
  end

  def has_finished?
    done_exam == exam
  end

  def refresh(sentence)
    return self if sentence.done_exam?(self)

    sentence.move_done(self)

    sentence.user_failure(user).refresh(result)
    
    self.error_count = self.error_count + 1 unless result
    self.done_count = self.done_count + 1
    self.save
    reload

    self
  end


  def points
    return 1 if self.error_count == 1
    return 10 if self.error_count == 0
    0
  end

  def save_points(source)
    return nil if source.nil?
    return unless has_finished?

    source_points = source.user_points(user)

    source_points.points = source_points.points + points
    source_points.save

    user.points = user.points + points
    user.save
    user.reload
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
        UserExercise.create(
          :user => self, :exam => source.generate_exam, :kind => source.class.name.downcase)
        reload
      end

      exercise.init_value(source)
    end

    def total_points
      total = 0

      lesson_points = LessonPoint.where(:user_id => self.id)
      lesson_points.map { |p| total = p.points + total } unless lesson_points.blank?

      practice_points = PracticePoint.where(:user_id => self.id)
      practice_points.map { |p| total = p.points + total } unless practice_points.blank?

      failure = SentenceFailurePoint.where(:user_id => self.id).first
      total = failure.points + total unless failure.nil?

      total
    end

  end

end