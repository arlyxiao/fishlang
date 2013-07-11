class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam, :error_count, 
                  :has_finished, :points, :done_count, :done_exam

  belongs_to :user
  belongs_to :practice


  validates :user, :practice, :exam, :presence => true

  after_create :init_default_value

  def init_default_value
    self.exam = practice.generate_exam if self.has_finished || self.exam.blank?
    self.error_count = 0
    self.done_count = 0
    self.has_finished = false
    self.done_exam = nil
    self.save
    self
  end


  def refresh_error_count
    self.error_count = self.error_count + 1
    self.save
    self.error_count
  end

  def refresh_done_count
    self.done_count = self.done_count + 1
    self.save
    self.done_count
  end

  def disable
    self.points = self.points + added_points
    self.has_finished = true
    self.save
  end

  def added_points
    number = 0
    number = 1 if self.error_count == 1
    number = 10 if self.error_count == 0
    number
  end



  module UserMethods
    def self.included(base)
      base.has_many :practices, :class_name => 'UserPractice', :foreign_key => :user_id
    end

    def get_practice(practice)
      practices.where(:practice_id => practice.id).first
    end

    def build_sentences(practice)
      return _create_sentences(practice) unless _has_practice?(practice)

      get_practice(practice).init_default_value
    end

    def get_sentence_ids(practice)
      return nil unless _has_practice?(practice)

      exam = get_practice(practice).exam
      return [] if exam.blank?
      JSON.parse(exam)
    end
    

    private
      def _has_practice?(practice)
        practices.where(:practice_id => practice.id).exists?
      end

      def _has_disabled?(practice)
        practices.where(:practice_id => practice.id, :has_finished => true).exists?
      end

      def _create_sentences(practice)
        practices.create(:practice => practice, :exam => practice.generate_exam)
      end

  end

end