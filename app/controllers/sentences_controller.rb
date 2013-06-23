class SentencesController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:id]) if params[:id]
  end


  def index
    sentences = Sentence.all
    render json: sentences
  end

  def show
    render json: @sentence
  end


  def check
    result = @sentence.translate?(params[:subject])
    
    render json: @sentence.next_id if result
    render json: result unless result
  end


  def continue
    render json: @sentence.next
  end

end
