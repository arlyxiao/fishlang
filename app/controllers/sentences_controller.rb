class SentencesController < ApplicationController

  def index
    sentences = Sentence.all
    render json: sentences
  end

  def show
    render json: Sentence.find(params[:id])
  end

end
