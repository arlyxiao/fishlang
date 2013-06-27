class Admin::LessonsController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @lessons = Lesson.all
    @lesson = Lesson.find(params[:id]) if params[:id]
  end


  def show
  end


end
