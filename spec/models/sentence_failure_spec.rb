require "spec_helper"

describe SentenceFailure do
  before {
    @user = FactoryGirl.create(:user)
    @sentence = FactoryGirl.create(:sentence)

    @sentence_failure = @sentence.user_failure(@user)
  }

  it "0 sentence failure" do
    @sentence_failure.count.should == 0
  end

  it "refresh error" do
    expect{
      @sentence_failure.refresh
    }.to change{@sentence_failure.count}.by(1)
  end


end