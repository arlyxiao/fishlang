class Admin::PracticesController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @practice = Practice.find(params[:id]) if params[:id]
  end

end
