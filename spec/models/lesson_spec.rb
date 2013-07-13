require "spec_helper"

describe Lesson do
  before {
    @lesson = FactoryGirl.create(:lesson)
    @practice_1 = FactoryGirl.create(:practice, :lesson => @lesson)
    @practice_2 = FactoryGirl.create(:practice, :lesson => @lesson)

    12.times { FactoryGirl.create(:sentence, :practice => @practice_1) }
    12.times { FactoryGirl.create(:sentence, :practice => @practice_2) }

    @exam = @lesson.generate_exam

    @exams = JSON.parse(@exam)
  }

  it "count" do
    @exams.count.should == 10
  end


end