class Sentence < ActiveRecord::Base
  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

end