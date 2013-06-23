class LessonsController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @lesson = Lesson.find(params[:id]) if params[:id]
  end


  def index
    lessons = Lesson.all
    render json: lessons
  end

  def show
    render json: @lesson
  end

end
