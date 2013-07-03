class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam

  belongs_to :user
  belongs_to :practice


  validates :user, :practice, :exam, :presence => true


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
      get_practice(practice).destroy if _has_practice?(practice)

      exam = practice.sentences.sample(10).map(&:id).join(',')
      practices.create(:practice => practice, :exam => exam)
    end

    def get_sentences(practice)
      return nil unless _has_practice?(practice)

      sentences = get_practice(practice).exam.split(',').map {
        |sentence_id| Sentence.find(sentence_id)
      }
    end

    def refresh_error_count(practice)
      user_practice = get_practice(practice)
      user_practice.error_count = user_practice.error_count + 1
      user_practice.save
    end

    private
      def _has_practice?(practice)
        practices.where(:practice_id => practice.id).exists?
      end

  end

end