class Sentence < ActiveRecord::Base
  attr_accessible :content

  has_many :translations, :class_name => 'SentenceTranslation', :foreign_key => :sentence_id

  validates :content, :presence => true

  def translate?(content)
    translations.map(&:content).include? content
  end
end