class UserPractice < ActiveRecord::Base
  attr_accessible :user, :practice, :exam

  belongs_to :user
  belongs_to :practice


  validates :user, :practice, :exam, :presence => true


  module UserMethods
    def self.included(base)
      base.has_many :practices, :class_name => 'UserPractice', :foreign_key => :user_id
    end

    def get_practice(practice)
      practices.where(:practice_id => practice.id).first
    end

    def get_practice_sentences(practice)
      _store_practice(practice) unless _has_practice?(practice)

      sentences = get_practice(practice).exam.split(',').map {
        |sentence_id| Sentence.find(sentence_id)
      }
    end

    private
      def _has_practice?(practice)
        practices.where(:practice_id => practice.id).exists?
      end

      def _store_practice(practice)
        exam = practice.sentences.sample(10).map(&:id).join(',')
        practices.create(:practice => practice, :exam => exam)
      end

  end

end