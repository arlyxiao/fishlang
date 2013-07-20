class Sentence < ActiveRecord::Base
  attr_accessible :practice, :subject, :verb

  belongs_to :practice
  has_many :translations, 
           :class_name => 'SentenceTranslation', 
           :foreign_key => :sentence_id,
           :dependent => :destroy

  validates :practice, :subject, :verb, :presence => true
  validates :subject, :uniqueness => {:case_sensitive => false}

  def next_id_by(user)
    user_exercise = user.exercise
    return nil unless self.is_exam?(user_exercise)

    ids = user_exercise.sentence_ids
    return nil if ids.last == self.id

    ids[ids.index(self.id) + 1]
  end

  def translate?(subject)
    subjects = translations.map!{|c| 
      _reorganize(c.subject)
    }
    subjects.include? _reorganize(subject)
  end

  def move_done(user_exercise)
    ids = [] if user_exercise.done_exam.blank?
    ids = JSON.parse(user_exercise.done_exam) unless user_exercise.done_exam.blank?

    ids << self.id
    user_exercise.done_exam = ids.to_json
    user_exercise.save
  end

  def done_exam?(user_exercise)
    ids = [] if user_exercise.done_exam.blank?
    ids = JSON.parse(user_exercise.done_exam) unless user_exercise.done_exam.blank?

    ids.include? self.id
  end

  def is_exam?(user_exercise)
    user_exercise.sentence_ids.include? self.id
  end

  private
    def _reorganize(str)
      a = str.downcase.strip.squeeze(' ')
      a.sub( /^((yo)|(tú)|(ellos)|(ellas)|(nosotros)|(nosotras))/, '' ).downcase.strip.squeeze(' ')
    end


  include SentenceFailure::SentenceMethods
  
end