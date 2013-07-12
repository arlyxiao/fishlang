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
    @practice = Practice.find(session[:practice_id])

    @user_practice = current_user.exercise
  end

  def done
    @user_practice = current_user.exercise
  end

end
