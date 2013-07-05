require 'spec_helper'

describe PracticesController do
  before {
    @user = FactoryGirl.create :user
    @practice = FactoryGirl.create :practice
    12.times { FactoryGirl.create(:sentence, :practice => @practice) }
  }

  it "user has no any practice" do
    @user.get_practice(@practice).should == nil
  end

  describe "#show" do
    before {
      sign_in @user
      get 'show', :id => @practice.id
    }

    it "practice_id in session should be correct" do
      session[:practice_id].should == @practice.id
    end

    it "user has practice" do
      @user.get_practice(@practice).valid?.should == true
    end
  end

end