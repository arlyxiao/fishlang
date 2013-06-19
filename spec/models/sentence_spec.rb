require "spec_helper"

describe Sentence do

  before {
    @sentence = FactoryGirl.create(:sentence, :content => 'estoy bien')
    @sentence_translation_1 = FactoryGirl.create(:sentence_translation, :content => "I'm file")
    @sentence_translation_2 = FactoryGirl.create(:sentence_translation, :content => 'I am fine')
  }

  it "sentence translation(1) should be correct" do
    @sentence.translate?(@sentence_translation_1).should == true
  end

  it "sentence translation(2) should be correct" do
    @sentence.translate?(@sentence_translation_2).should == true
  end

  
end