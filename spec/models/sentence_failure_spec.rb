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


  describe "refresh" do

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


  describe "by_count" do
    before {
      5.times { FactoryGirl.create(:sentence_failure, :count => 1, :correct_count => 4) }
      8.times { FactoryGirl.create(:sentence_failure, :count => 1, :correct_count => 1) }
      2.times { FactoryGirl.create(:sentence_failure, :count => 1, :correct_count => 2) }
    }

    it "result" do
      SentenceFailure.by_count.count.should == 10
    end
  end


end