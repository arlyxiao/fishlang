class SentenceFailuresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence_failure = SentenceFailure.find(params[:id]) if params[:id]
  end

  def index    
    @sentence_failures = current_user.sentence_failures.page params[:page]
  end

end