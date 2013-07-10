class Admin::LessonsController < ApplicationController
	layout 'admin'
  before_filter :pre_load
  
  def pre_load
    @lessons = Lesson.all
    @lesson = Lesson.find(params[:id]) if params[:id]
  end

  def show
  end

end
