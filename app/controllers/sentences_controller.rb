class SentencesController < ApplicationController

  def index
    sentences = Sentence.all
    render json: sentences
  end

  def show
    render json: Sentence.find(params[:id])
  end

  def check
    @sentence = Sentence.find(params[:id])
    result = @sentence.translate?(params[:subject])
    
    render json: result
  end

end
