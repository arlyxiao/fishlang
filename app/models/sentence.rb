class Sentence < ActiveRecord::Base
  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

  validates :content, :presence => true

  def translate?(content)
    translations.map(&:content).include? content
  end
end