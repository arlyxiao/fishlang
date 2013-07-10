class Admin::UsersController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @user = User.find(params[:id]) if params[:id]
  end

  def index
  	@users = User.page params[:page]
  end

  def show
  end

end
