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

    current_user.build_sentences(@practice)
    @sentences = current_user.get_sentences(@practice)
  end

  def exam
    @practice = Practice.find(session[:practice_id])

    @user_practice = current_user.get_practice(@practice)
  end

  def done
    @user_practice = current_user.get_practice(@practice)
  end

end
