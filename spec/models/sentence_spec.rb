require "spec_helper"

describe Sentence do

  before {
    @sentence = FactoryGirl.create(:sentence, :content => 'estoy bien')
    @sentence_translation_1 = FactoryGirl.create(:sentence_translation, 
      :sentence => @sentence,
      :content => "I'm file"
    )

    @sentence_translation_2 = FactoryGirl.create(:sentence_translation,
      :sentence => @sentence,
     :content => 'I am fine'
    )

    @content_1 = "I'm file"
    @content_2 = 'I am fine'
    @content_3 = 'am fine'
  }

  it "sentence translation(1) should be correct" do
    @sentence.translate?(@content_1).should == true
  end

  it "sentence translation(2) should be correct" do
    @sentence.translate?(@content_2).should == true
  end

  it "sentence translation(3) should be incorrect" do
    @sentence.translate?(@content_3).should == false
  end

  
end