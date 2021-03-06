class Admin::SentencesController < ApplicationController
  layout 'admin'
  before_filter :pre_load
  
  def pre_load
    @practice = Practice.find(params[:practice_id]) if params[:practice_id]
    @sentence = Sentence.find(params[:id]) if params[:id]
  end

  
  def create    
    @practice.sentences.create(params[:sentence])

    redirect_to "/admin/practices/#{@practice.id}"
  end

  def destroy
    practice_id = @sentence.practice.id
    @sentence.destroy

    redirect_to "/admin/practices/#{practice_id}"
  end

  
end
