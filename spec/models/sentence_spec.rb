require "spec_helper"

describe Sentence do
  before {
    @lesson_1 = Lesson.create(:name => 'Present')
    @lesson_2 = Lesson.create(:name => 'Present Perfect')
  }

  describe "Validate next_id" do
    before {
      @sentence_1_1 = FactoryGirl.create(:sentence, :lesson => @lesson_1)
      @sentence_2_1 = FactoryGirl.create(:sentence, :lesson => @lesson_2)
      @sentence_1_2 = FactoryGirl.create(:sentence, :lesson => @lesson_1)
      @sentence_1_3 = FactoryGirl.create(:sentence, :lesson => @lesson_1)
      @sentence_2_2 = FactoryGirl.create(:sentence, :lesson => @lesson_2)
    }

    describe "order in lesson_1" do
      it "next_id of sentence_1_1" do
        @sentence_1_1.next_id.should == @sentence_1_2.id
      end

      it "next_id of sentence_1_2" do
        @sentence_1_2.next_id.should == @sentence_1_3.id
      end
    end

    describe "order in lesson_2" do
      it "next_id of sentence_2_1" do
        @sentence_2_1.next_id.should == @sentence_2_2.id
      end
    end
  end

  describe "Validate translate" do

    before {
      @sentence = FactoryGirl.create(:sentence, :lesson => @lesson_1, :subject => 'estoy bien')
      @sentence_translation_1 = FactoryGirl.create(:sentence_translation, 
        :sentence => @sentence,
        :subject => "I'm file"
      )

      @sentence_translation_2 = FactoryGirl.create(:sentence_translation,
        :sentence => @sentence,
       :subject => 'I am fine'
      )

      
    }

    describe "Without additional spaces among words" do
      before {
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

    describe "With additional spaces among words" do
      before {
        @subject_1 = "I'm     file  "
        @subject_2 = '   I    am    fine'
      }

      it "sentence translation(1) should be correct" do
        @sentence.translate?(@subject_1).should == true
      end

      it "sentence translation(2) should be correct" do
        @sentence.translate?(@subject_2).should == true
      end
    end

  end

  
  
end