class Sentence < ActiveRecord::Base
  attr_accessible :practice, :subject, :verb, :verb_tense

  belongs_to :practice
  belongs_to :verb_tense
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
      str = str.downcase.strip.squeeze(' ')
      return str if verb_tense.nil?

      yo = "yo #{verb_tense.yo}"
      tu = "tú #{verb_tense.tu}"
      el = "él #{verb_tense.el}"
      ella = "ella #{verb_tense.ella}"
      usted = "usted #{verb_tense.usted}"
      nosotros = "nosotros #{verb_tense.nosotros}"
      nosotras = "nosotras #{verb_tense.nosotras}"
      vosotros = "vosotros #{verb_tense.vosotros}"
      vosotras = "vosotras #{verb_tense.vosotras}"
      ellos = "ellos #{verb_tense.ellos}"
      ellas = "ellas #{verb_tense.ellas}"
      ustedes = "ustedes #{verb_tense.ustedes}"

      pattern = "((#{yo})|(#{tu})|(#{el})|(#{ella})|(#{usted})|(#{nosotros})|(#{nosotras})|(#{vosotros})|(#{vosotras})|(#{ellos})|(#{ellas})|(#{ustedes}))"

      match_words = str[/^#{pattern}/]
      return str if match_words.nil?


      replace_word = match_words.split(' ')[1]
      str = str.sub( %r{^#{pattern}}, replace_word )

      str.downcase.strip
    end


  include SentenceFailure::SentenceMethods
  
end