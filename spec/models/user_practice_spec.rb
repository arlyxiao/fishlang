require "spec_helper"

describe UserPractice do
  before {
    @up = FactoryGirl.create(:user_practice)
    @error_count = @up.error_count
    @done_count = @up.error_count
  }


  it "validate error count" do
    (@up.refresh_error_count - @error_count).should == 1
  end

  it "validate done count" do
    (@up.refresh_done_count - @done_count).should == 1
  end

  describe "validate disable" do
    before {
      @up.disable
    }

    it "has_finished should be true" do
      @up.has_finished.should == true
    end
  end
end