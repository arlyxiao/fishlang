class Admin::SentenceTranslationsController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:sentence_id]) if params[:sentence_id]
    @translation = SentenceTranslation.find(params[:id]) if params[:id]
  end

  
  def create    
    @sentence.translations.create(params[:sentence_translation])

    redirect_to "/admin/practices/#{@sentence.practice.id}"
  end

  def destroy
    practice_id = @translation.sentence.practice.id
    @translation.destroy

    redirect_to "/admin/practices/#{practice_id}"
  end


end
