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

    current_user.get_practice(@sentence.practice).refresh_error_count unless result
    
    render json: {:next_id => @sentence.next_id_by(current_user), :result => result}
  end


end
