class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam, :error_count, :has_finished

  belongs_to :user
  belongs_to :practice


  validates :user, :practice, :exam, :presence => true

  after_create :init_default_value

  def init_default_value
    self.error_count = 0
    self.has_finished = false
    self.save
  end


  def refresh_error_count
    self.error_count = self.error_count + 1
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
      if _has_practice?(practice)
        u_p = get_practice(practice)
        u_p.update_attributes({:has_finished => false, :error_count => 0})
        return
      end

      exam = practice.sentences.sample(10).map(&:id).join(',')
      practices.create(:practice => practice, :exam => exam)
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

  end

end