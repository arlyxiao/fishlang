class PracticesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :pre_load
  
  def pre_load
    @practice = Practice.find(params[:id]) if params[:id]
  end


  def index
    @practices = Practice.all
  end

  def show
    session[:practice_id] = @practice.id

    current_user.build_exercise(@practice)

    @sentence_ids = current_user.build_exercise(@practice).sentence_ids
  end

  def exam
    @at_exam = true
    session[:current_type] = 'practice'
    @practice = Practice.find(session[:practice_id])

    @user_exercise = current_user.exercise
  end

  def done
    # return redirect_to "/lessons" unless current_user.exercise.has_finished?
    return redirect_to "/lessons" unless session[:current_type]

    @practice = Practice.find(session[:practice_id]) if session[:current_type] == 'practice'
    @user_exercise = current_user.exercise

    session[:current_type] = nil
    session[:practice_id] = nil
  end

end
