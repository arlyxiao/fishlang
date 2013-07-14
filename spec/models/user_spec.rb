require "spec_helper"

describe User do
  before {
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)

    FactoryGirl.create(:sentence_failure_point, :user => @user_1, :points => 2)
    FactoryGirl.create(:sentence_failure_point, :user => @user_2, :points => 3)

    2.times { FactoryGirl.create(:lesson_point, :user => @user_1, :points => 10) }
    2.times { FactoryGirl.create(:practice_point, :user => @user_1, :points => 20) }

    3.times { FactoryGirl.create(:lesson_point, :user => @user_2, :points => 10) }
    3.times { FactoryGirl.create(:practice_point, :user => @user_2, :points => 20) }
  }

  it "user_1 total points" do
    @user_1.total_points.should == 62
  end

  it "user_2 total points" do
    @user_2.total_points.should == 93
  end


end