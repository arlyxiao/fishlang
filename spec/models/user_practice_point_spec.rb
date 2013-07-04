require "spec_helper"

describe UserPracticePoint do
  before {
    @u = FactoryGirl.create(:user)
    @p = FactoryGirl.create(:practice)
    @u_p = FactoryGirl.create(:user_practice, :user => @u, :practice => @p)

    @point = FactoryGirl.create(:user_practice_point, :user => @u, :practice => @p)
    @number = @point.number
  }


  describe "validate set_number" do

    it "should increase 10 when error_count is 0" do
      @point.set_number(@u_p)
      @point.reload

      (@point.number - @number).should == 10
    end
    
    it "should increase 1 when error_count is more than 0" do
      @u_p.refresh_error_count
      @point.set_number(@u_p)
      @point.reload

      (@point.number - @number).should == 1
    end
    
  end

  
end