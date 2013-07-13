require "spec_helper"

describe SentenceFailure do
  before {
    @user = FactoryGirl.create(:user)
    @sentence = FactoryGirl.create(:sentence)

    @sentence_failure = @sentence.user_failure(@user)
  }

  it "count" do
    @sentence_failure.count.should == 0
  end

  it "correct count" do
    @sentence_failure.correct_count.should == 0
  end

  describe "refresh with false" do
    before {
      @sentence_failure.refresh(false)
    }

    it "count" do
      @sentence_failure.count.should == 1
    end

    it "correct count" do
      @sentence_failure.correct_count.should == 0
    end

    describe "refresh with true" do
      before {
        @sentence_failure.refresh(true)
      }

      it "count" do
        @sentence_failure.count.should == 1
      end

      it "correct count" do
        @sentence_failure.correct_count.should == 1
      end
      
    end

  end

  describe "refresh with true" do
    before {
      @sentence_failure.refresh(true)
    }

    it "count" do
      @sentence_failure.count.should == 0
    end

    it "correct count" do
      @sentence_failure.correct_count.should == 0
    end
    
  end


end