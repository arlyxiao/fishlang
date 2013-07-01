class SentencesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:id]) if params[:id]
  end


  def show
    render json: @sentence
  end


  def check
    result = @sentence.translate?(params[:subject])
    
    render json: {:next_id => @sentence.next_id_by(current_user), :result => result}
  end


end
