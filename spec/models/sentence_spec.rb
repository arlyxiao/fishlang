require "spec_helper"

describe Sentence do
  before {
    @u1 = FactoryGirl.create(:user)
    @u2 = FactoryGirl.create(:user)

    @p1 = FactoryGirl.create(:practice)
    @p2 = FactoryGirl.create(:practice)
  }

  describe "Validate sentence" do
    before {
      12.times { FactoryGirl.create(:sentence, :practice => @p1) }
      12.times { FactoryGirl.create(:sentence, :practice => @p2) }
    }

    describe "validate build_sentences and get_sentences" do
      before {
        @u1.build_sentences(@p1)
        @u1_sentences = @u1.get_sentences(@p1)
        @u1_practice = @u1.get_practice(@p1)
      }

      it "validate exam field" do
        @u1_practice.exam.split(',').count.should == 10
      end

      it "error_count should be 0" do
        @u1_practice.error_count.should == 0
      end

      it "has_finished should be 0" do
        @u1_practice.has_finished.should == false
      end

      it "same when build_sentences again" do
        @u1.build_sentences(@p1)
        @u1.get_sentences(@p1).should == @u1_sentences
      end

      describe "destroy user practice" do
        before {
          @u1_practice.destroy
        }
        

        it "nil sentences" do
          @u1.get_sentences(@p1).should == nil
        end

        it "sentences are different after build_sentences again" do
          @u1.build_sentences(@p1)
          @u1.get_sentences(@p1).should_not == @u1_sentences
        end

      end

    end

    

    describe "Validate sentences" do
      before {
        @u1.build_sentences(@p1)
        @u2.build_sentences(@p1)

        @u1_sentences = @u1.get_sentences(@p1)
        @u2_sentences = @u2.get_sentences(@p1)

        @u1_practice = @u1.get_practice(@p1)
      }


      it "u1 practice are not equal to u2 practice" do
        @u1_sentences.should_not == @u2_sentences
      end

      it "sentences number should be equal" do
        @u1_sentences.count.should == @u2_sentences.count
      end

      describe "next id should be correct" do
        before {
          @u1_ids = @u1_sentences.map(&:id)
        }

        it "next of each element" do
          (0..9).each do |i|
            break if i == 9
            @u1_sentences[i].next_id_by(@u1).should == @u1_ids[i + 1]
          end
        end

        describe "finish practice" do
          before {
            (0..9).each do |i|
              @u1_sentences[i].next_id_by(@u1)
            end
          }
          
          it "has_finished should be true" do
            @u1.get_practice(@p1).has_finished.should == true
          end

          it "points added" do
            @u1.get_practice(@p1).points.should == 10
          end
        end

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