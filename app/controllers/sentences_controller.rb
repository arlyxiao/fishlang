class SentencesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:id]) if params[:id]
  end


  def show
    p = current_user.get_practice(@sentence.practice)

    render json: @sentence
  end


  def check
    p = current_user.get_practice(@sentence.practice)

    result = @sentence.translate?(params[:subject])

    unless @sentence.done_exam_in?(p)
      p.refresh_done_count
      p.refresh_error_count unless result
      @sentence.move_done_in(p)
    end
    
    render json: {
      :next_id => @sentence.next_id_by(current_user), 
      :result => result, 
      :error_count => p.error_count,
      :done_count => p.done_count
    }
  end


  def report
    SentenceReport.create(
      :user => current_user, 
      :sentence => @sentence, 
      :user_answer => params[:user_answer],
      :content => params[:content]
    )

    render :nothing => true
  end


end
