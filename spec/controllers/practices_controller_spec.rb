require 'spec_helper'

describe PracticesController do
  before {
    @user = FactoryGirl.create :user
    @practice = FactoryGirl.create :practice
    12.times { FactoryGirl.create(:sentence, :practice => @practice) }
  }


  describe "#show" do
    before {
      sign_in @user
      get 'show', :id => @practice.id
      @user_exercise = @user.build_exercise(@practice)
    }

    it "practice_id in session should be correct" do
      session[:practice_id].should == @practice.id
    end

    it "user has practice" do
      @user_exercise.valid?.should == true
    end

    it "error_count" do
      @user_exercise.error_count.should == 0
    end

    it "done_count" do
      @user_exercise.done_count.should == 0
    end

    it "has_finished" do
      @user_exercise.has_finished?.should == false
    end

    it "done_exam" do
      @user_exercise.done_exam.should be_nil
    end


    describe "go into show page again" do
      before {
        @user_exercise.error_count = 5
        @user_exercise.done_count = 3
        @user_exercise.done_exam = 'sss'
        @user_exercise.save

        get 'show', :id => @practice.id
        @user_exercise = @user.build_exercise(@practice)
      }

      it "error_count" do
        @user_exercise.error_count.should == 0
      end

      it "done_count" do
        @user_exercise.done_count.should == 0
      end

      it "done_exam" do
      @user_exercise.done_exam.should be_nil
    end
    end

  end

end