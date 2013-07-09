class Admin::SentenceReportsController < ApplicationController

  before_filter :pre_load
  
  def pre_load
    @sentence_report = SentenceReport.find(params[:id]) if params[:id]
  end

  
  def index    
    @sentence_reports = SentenceReport.page params[:page]
  end

  def show
  end

  def destroy
    @sentence_report.destroy

    redirect_to "/admin/sentence_reports"
  end

  
end
