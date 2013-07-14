class SentenceFailuresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence_failure = SentenceFailure.find(params[:id]) if params[:id]
  end

  def index    
    @sentence_failures = current_user.sentence_failures.by_count.page params[:page]

    unless @sentence_failures.blank?
      @user_exercise = current_user.build_exercise(@sentence_failures.first)
      @sentence_ids = @user_exercise.sentence_ids
    end

  end

  def exam
  	@at_exam = true
  	session[:current_type] = 'sentence_failure'

    @user_exercise = current_user.exercise
  end

end