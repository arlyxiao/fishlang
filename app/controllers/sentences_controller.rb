class SentencesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @sentence = Sentence.find(params[:id]) if params[:id]
  end


  def show
    user_exercise = current_user.exercise
    return render json: nil unless @sentence.is_exam?(user_exercise)

    render json: @sentence
  end


  def check
    user_exercise = current_user.exercise

    return render json: nil unless @sentence.is_exam?(user_exercise)

    user_exercise.result = @sentence.translate?(params[:subject])

    user_exercise.refresh(@sentence)
    
    render json: {
      :next_id => @sentence.next_id_by(current_user), 
      :result => user_exercise.result, 
      :error_count => user_exercise.error_count,
      :done_count => user_exercise.done_count
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
