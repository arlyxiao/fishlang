require "spec_helper"

describe UserPracticePoint do
  before {
    @point = FactoryGirl.create(:user_practice_point)
    @number = @point.number
  }


  it "validate set_full_number" do
    @point.set_full_number
    @point.reload
    (@point.number - @number).should == 10
  end

  it "validate set_junior_number" do
    @point.set_junior_number
    @point.reload
    (@point.number - @number).should == 1
  end
end