class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam, :error_count, :has_finished, :points

  belongs_to :user
  belongs_to :practice


  validates :user, :practice, :exam, :presence => true

  after_create :init_default_value

  def init_default_value
    self.exam = practice.generate_exam
    self.error_count = 0
    self.has_finished = false
    self.save
    self
  end


  def refresh_error_count
    self.error_count = self.error_count + 1
    self.save
  end

  def disable
    self.has_finished = true
    self.save
  end



  module UserMethods
    def self.included(base)
      base.has_many :practices, :class_name => 'UserPractice', :foreign_key => :user_id
    end

    def get_practice(practice)
      practices.where(:practice_id => practice.id).first
    end

    def build_sentences(practice)
      return get_practice(practice).init_default_value if _has_disabled?(practice)

      return _create_sentences(practice) unless _has_practice?(practice)
    end

    def get_sentences(practice)
      return nil unless _has_practice?(practice)

      sentences = get_practice(practice).exam.split(',').map {
        |sentence_id| Sentence.find(sentence_id)
      }
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