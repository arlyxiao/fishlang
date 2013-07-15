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
      @user_exercise = @user.exercise
      @exam = @user_exercise.exam
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
        get 'show', :id => @practice.id
      }

      it "different exam" do
        assigns(:user_exercise).exam.should_not eq(@exam) 
      end

      it "user_exercise" do
        assigns(:user_exercise).should eq(@user_exercise) 
      end
    end

  end

end