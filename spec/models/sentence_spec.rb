require "spec_helper"

describe Sentence do
  before {
    @u1 = FactoryGirl.create(:user)
    @u2 = FactoryGirl.create(:user)

    @p1 = FactoryGirl.create(:practice)
    @p2 = FactoryGirl.create(:practice)
  }

  describe "Validate next_id" do
    before {
      12.times { FactoryGirl.create(:sentence, :practice => @p1) }
      12.times { FactoryGirl.create(:sentence, :practice => @p2) }

      @u1_practice_sentences = @u1.get_practice_sentences(@p1)
      @u2_practice_sentences = @u2.get_practice_sentences(@p1)
    }

    it "validate get_practice of user" do
      @u1.get_practice(@p1).exam.split(',').count.should == 10
    end

    it "u1 practice are not equal to u2 practice" do
      @u1_practice_sentences.should_not == @u2_practice_sentences
    end

    it "sentences number should be equal" do
      @u1_practice_sentences.count.should == @u2_practice_sentences.count
    end

    describe "next id should be correct" do
      before {
        @u1_ids = @u1_practice_sentences.map(&:id)
      }

      it "next of each element" do
        (0..9).each do |i|
          break if i == 9
          @u1_practice_sentences[i].next_id_by(@u1).should == @u1_ids[i + 1]
        end
      end

      it "same practice" do
        @u1.get_practice_sentences(@p1).should == @u1_practice_sentences
      end

      it "different practice" do
        (0..9).each do |i|
          @u1_practice_sentences[i].next_id_by(@u1)
        end

        @u1.get_practice_sentences(@p1).should_not == @u1_practice_sentences
      end

    end


  end

  describe "Validate translate" do

    before {
      @sentence = FactoryGirl.create(:sentence, :practice => @p1, :subject => 'estoy bien')
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