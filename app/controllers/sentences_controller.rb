class SentencesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:id]) if params[:id]
  end


  def show
    p = @sentence.practice.user_practice(current_user)
    return render json: nil unless @sentence.is_exam?(p)

    render json: @sentence
  end


  def check
    user_practice = @sentence.practice.user_practice(current_user)

    return render json: nil unless @sentence.is_exam?(user_practice)

    user_practice.result = @sentence.translate?(params[:subject])

    user_practice.refresh(@sentence)
    
    render json: {
      :next_id => @sentence.next_id_by(current_user), 
      :result => user_practice.result, 
      :error_count => user_practice.error_count,
      :done_count => user_practice.done_count
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
