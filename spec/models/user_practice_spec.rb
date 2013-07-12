require "spec_helper"

describe UserPractice do
  before {
    @user = FactoryGirl.create(:user)
    @practice = FactoryGirl.create(:practice)

    10.times { @sentence = FactoryGirl.create(:sentence, :practice => @practice) }

    @user.build_sentences(@practice)
    @user_practice = @practice.user_practice(@user)

    @user_practice.result = false
  }


  it "validate error count" do
    expect{
      @user_practice.refresh(@sentence)
    }.to change{@user_practice.error_count}.by(1)
  end

  it "validate done count" do
    expect{
      @user_practice.refresh(@sentence)
    }.to change{@user_practice.done_count}.by(1)
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