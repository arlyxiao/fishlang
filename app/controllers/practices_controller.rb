class PracticesController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @practice = Practice.find(params[:id]) if params[:id]
  end


  def index
    @practices = Practice.all
  end

end
