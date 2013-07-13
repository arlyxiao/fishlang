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

    @user_exercise = current_user.build_exercise(@practice)
    @sentence_ids = @user_exercise.sentence_ids
  end

  def exam
    @at_exam = true
    session[:current_type] = 'practice'
    @practice = Practice.find(session[:practice_id])

    @user_exercise = current_user.exercise
  end

  def done
    return redirect_to "/lessons" unless session[:current_type]

    if session[:current_type] == 'practice'
      @practice = Practice.find(session[:practice_id])
    end

    if session[:current_type] == 'lesson'
      @lesson = Lesson.find(session[:lesson_id])
    end

    @user_exercise = current_user.exercise

    # return redirect_to "/lessons" unless @user_exercise.has_finished?

    #session[:current_type] = nil
    #session[:practice_id] = nil
    #session[:lesson_id] = nil
  end

end
