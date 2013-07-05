require "spec_helper"

describe UserPractice do
  before {
    @u_p = FactoryGirl.create(:user_practice)
    @error_count = @u_p.error_count
    
  }


  it "validate error count" do
    (@u_p.refresh_error_count - @error_count).should == 1
  end

  describe "validate disable" do
    before {
      @u_p.disable
    }

    it "has_finished should be true" do
      @u_p.has_finished.should == true
    end
  end
end