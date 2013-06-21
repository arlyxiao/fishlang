class SentencesController < ApplicationController

  def index
    sentences = Sentence.all
    render json: sentences
  end

end
