require "spec_helper"

describe UserPractice do
  before {
    @u_p = FactoryGirl.create(:user_practice)
    @error_count = @u_p.error_count
  }


  it "validate error count" do
    @u_p.refresh_error_count
    @u_p.reload
    (@u_p.error_count - @error_count).should == 1
  end
end