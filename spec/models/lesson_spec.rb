require "spec_helper"

describe Lesson do
  before {
    @l = FactoryGirl.create(:lesson)
    @p = FactoryGirl.create(:practice, :lesson => @l)

    20.times { FactoryGirl.create(:sentence, :practice => @p) }
  }

  it "Correct numbers of each practice" do
    @p.exam_sentences.count.should == 10
  end

end