class LessonsController < ApplicationController
  before_filter :pre_load
  
  def pre_load
    @lessons = Lesson.all
    @lesson = Lesson.find(params[:id]) if params[:id]
  end


  def show
    authenticate_user!
    @practices = @lesson.practices

    @user_exercise = current_user.build_exercise(@lesson)
    @sentence_ids = @user_exercise.sentence_ids

    session[:lesson_id] = @lesson.id
  end

  def exam
    @at_exam = true
    session[:current_type] = 'lesson'
    @lesson = Lesson.find(session[:lesson_id])

    @user_exercise = current_user.exercise
  end

end
