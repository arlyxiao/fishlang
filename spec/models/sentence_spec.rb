require "spec_helper"

describe Sentence do

  before {
    @sentence = FactoryGirl.create(:sentence, :subject => 'estoy bien')
    @sentence_translation_1 = FactoryGirl.create(:sentence_translation, 
      :sentence => @sentence,
      :subject => "I'm file"
    )

    @sentence_translation_2 = FactoryGirl.create(:sentence_translation,
      :sentence => @sentence,
     :subject => 'I am fine'
    )

    @subject_1 = "I'm file"
    @subject_2 = 'I am fine'
    @subject_3 = 'am fine'
  }

  it "sentence translation(1) should be correct" do
    @sentence.translate?(@subject_1).should == true
  end

  it "sentence translation(2) should be correct" do
    @sentence.translate?(@subject_2).should == true
  end

  it "sentence translation(3) should be incorrect" do
    @sentence.translate?(@subject_3).should == false
  end

  
end