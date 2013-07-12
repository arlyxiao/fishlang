require "spec_helper"

describe Sentence do
  before {
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)

    @practice_1 = FactoryGirl.create(:practice)
    @practice_2 = FactoryGirl.create(:practice)
  }

  describe "Validate sentence" do
    before {
      12.times { FactoryGirl.create(:sentence, :practice => @practice_1) }
      12.times { FactoryGirl.create(:sentence, :practice => @practice_2) }
    }

    

    describe "validate build_sentences and get_sentence_ids" do
      before {
        @user_1.build_exercise(@practice_1)
        @user_exercise_1 = @user_1.exercise
        @sentence_ids_1 = @user_exercise_1.sentence_ids
      }

      describe "not in exam" do
        before {
          @s = FactoryGirl.create(:sentence, :practice => @practice_1)
        }

        it "should be false" do
          @s.is_exam?(@user_exercise_1).should == false
        end
      end

      it "validate exam field" do
        JSON.parse(@user_exercise_1.exam).count.should == 10
      end

      it "error_count should be 0" do
        @user_exercise_1.error_count.should == 0
      end

      it "has_finished should be 0" do
        @user_exercise_1.has_finished?.should == false
      end


      it "same when build_sentences again" do
        @user_1.build_exercise(@practice_1)
        @user_1.exercise.sentence_ids.should == @sentence_ids_1
      end

      describe "validate done exam" do

      end

      describe "destroy user exercise" do
        before {
          @user_exercise_1.destroy
          @user_1.reload
        }
        

        it "nil exercise" do
          @user_1.exercise.nil?.should == true
        end

        it "sentences are different after build_sentences again" do
          @user_1.build_exercise(@practice_1)
          @user_1.exercise.sentence_ids.should_not == @sentence_ids_1
        end

      end

    end

    

    describe "Validate sentences" do
      before {
        @user_1.build_exercise(@practice_1)
        @user_2.build_exercise(@practice_1)

        @sentence_ids_1 = @user_1.exercise.sentence_ids
        @sentence_ids_2 = @user_2.exercise.sentence_ids

        @user_exercise_1 = @user_1.exercise
      }

      describe "validate sentence done" do
        before {
          id = @sentence_ids_1.sample(1).first
          @sentence = Sentence.find(id)
        }

        it "is in exam" do
          @sentence.is_exam?(@user_exercise_1).should == true
        end

        it "not done in exam" do
          @sentence.done_exam?(@user_exercise_1).should == false
        end

        describe "done" do
          before {
            @sentence.move_done(@user_exercise_1)
          }

          it "done in exam" do
            @sentence.done_exam?(@user_exercise_1).should == true
          end 
        end
      end


      it "u1 practice are not equal to u2 practice" do
        @sentence_ids_1.should_not == @sentence_ids_2
      end

      it "sentences number should be equal" do
        @sentence_ids_1.count.should == @sentence_ids_2.count
      end

      describe "next id should be correct" do

        it "next of each element" do
          (0..9).each do |i|
            break if i == 9
            Sentence.find(@sentence_ids_1[i]).next_id_by(@user_1).should == @sentence_ids_1[i + 1]
          end
        end


      end

    end

    


  end

  describe "Validate translate" do

    before {
      @sentence = FactoryGirl.create(:sentence, :practice => @practice_1, :subject => 'estoy bien')
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