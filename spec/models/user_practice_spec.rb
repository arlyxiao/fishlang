require "spec_helper"

describe UserPractice do
  before {
    @user_practice = FactoryGirl.create(:user_practice)
    @error_count = @user_practice.error_count
    @done_count = @user_practice.error_count
  }


  it "validate error count" do
    (@user_practice.refresh_error_count - @error_count).should == 1
  end

  it "validate done count" do
    (@user_practice.refresh_done_count - @done_count).should == 1
  end

  describe "validate disable" do
    before {
      @user_practice.disable
    }

    it "has_finished should be true" do
      @user_practice.has_finished.should == true
    end
  end
end