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

    

    describe "validate build_sentences and get_sentence_ids" do
      before {
        @u1.build_sentences(@p1)
        @u1_sentence_ids = @u1.get_sentence_ids(@p1)
        @user_practice_1 = @p1.user_practice(@u1)
      }

      describe "not in exam" do
        before {
          @s = FactoryGirl.create(:sentence, :practice => @p1)
        }

        it "should be false" do
          @s.is_in_exam?(@user_practice_1).should == false
        end
      end

      it "validate exam field" do
        JSON.parse(@user_practice_1.exam).count.should == 10
      end

      it "error_count should be 0" do
        @user_practice_1.error_count.should == 0
      end

      it "has_finished should be 0" do
        @user_practice_1.has_finished.should == false
      end


      it "same when build_sentences again" do
        @u1.build_sentences(@p1)
        @u1.get_sentence_ids(@p1).should == @u1_sentence_ids
      end

      describe "validate done exam" do

      end

      describe "destroy user practice" do
        before {
          @user_practice_1.destroy
        }
        

        it "nil sentences" do
          @u1.get_sentence_ids(@p1).should == nil
        end

        it "sentences are different after build_sentences again" do
          @u1.build_sentences(@p1)
          @u1.get_sentence_ids(@p1).should_not == @u1_sentence_ids
        end

      end

    end

    

    describe "Validate sentences" do
      before {
        @u1.build_sentences(@p1)
        @u2.build_sentences(@p1)

        @u1_sentence_ids = @u1.get_sentence_ids(@p1)
        @u2_sentence_ids = @u2.get_sentence_ids(@p1)

        @user_practice_1 = @p1.user_practice(@u1)
      }

      describe "validate sentence done" do
        before {
          id = @u1_sentence_ids.sample(1).first
          @sentence = Sentence.find(id)
        }

        it "is in exam" do
          @sentence.is_in_exam?(@user_practice_1).should == true
        end

        it "not done in exam" do
          @sentence.done_exam_in?(@user_practice_1).should == false
        end

        describe "done" do
          before {
            @sentence.move_done_in(@user_practice_1)
          }

          it "done in exam" do
            @sentence.done_exam_in?(@user_practice_1).should == true
          end 
        end
      end


      it "u1 practice are not equal to u2 practice" do
        @u1_sentence_ids.should_not == @u2_sentence_ids
      end

      it "sentences number should be equal" do
        @u1_sentence_ids.count.should == @u2_sentence_ids.count
      end

      describe "next id should be correct" do

        it "next of each element" do
          (0..9).each do |i|
            break if i == 9
            Sentence.find(@u1_sentence_ids[i]).next_id_by(@u1).should == @u1_sentence_ids[i + 1]
          end
        end

        describe "finish practice" do
          before {
            (0..9).each do |i|
              Sentence.find(@u1_sentence_ids[i]).next_id_by(@u1)
            end
            @user_practice_1 = @p1.user_practice(@u1)
          }
          
          it "has_finished should be true" do
            @user_practice_1.has_finished.should == true
          end

          it "points added" do
            @user_practice_1.points.should == 10
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