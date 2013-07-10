class Admin::IndexController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
 
  def index
    redirect_to "/admin/users"
  end
end
