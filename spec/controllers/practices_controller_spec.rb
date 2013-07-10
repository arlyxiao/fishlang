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
      @user_practice = @user.get_practice(@practice)
    }

    it "practice_id in session should be correct" do
      session[:practice_id].should == @practice.id
    end

    it "user has practice" do
      @user_practice.valid?.should == true
    end

    it "error_count" do
      @user_practice.error_count.should == 0
    end

    it "done_count" do
      @user_practice.done_count.should == 0
    end

    it "has_finished" do
      @user_practice.has_finished.should == false
    end

    it "done_exam" do
      @user_practice.done_exam.should be_nil
    end


    describe "go into show page again" do
      before {
        @user_practice.error_count = 5
        @user_practice.done_count = 3
        @user_practice.done_exam = 'sss'
        @user_practice.save

        get 'show', :id => @practice.id
        @user_practice = @user.get_practice(@practice)
      }

      it "error_count" do
        @user_practice.error_count.should == 0
      end

      it "done_count" do
        @user_practice.done_count.should == 0
      end

      it "done_exam" do
      @user_practice.done_exam.should be_nil
    end
    end

  end

end