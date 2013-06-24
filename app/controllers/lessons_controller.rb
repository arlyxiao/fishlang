class LessonsController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @lesson = Lesson.find(params[:id]) if params[:id]
  end


  def index
    @lessons = Lesson.all
  end

  def show
    @practices = @lesson.practices
  end

end
