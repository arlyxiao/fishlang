class Admin::PracticesController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @lesson = Lesson.find(params[:lesson_id]) if params[:lesson_id]
    @practice = Practice.find(params[:id]) if params[:id]
  end


  def create
    @lesson.practices.create(params[:practice])

    redirect_to "/admin/lessons/#{@lesson.id}"
  end

  def destroy
    lesson_id = @practice.lesson.id
    @practice.destroy

    redirect_to "/admin/lessons/#{lesson_id}"
  end

  def show
    @lessons = Lesson.all
  end


end
