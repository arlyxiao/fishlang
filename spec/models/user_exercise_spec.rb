require "spec_helper"

describe UserExercise do
  before {
    @user = FactoryGirl.create(:user)
    @practice = FactoryGirl.create(:practice)

    12.times { @sentence = FactoryGirl.create(:sentence, :practice => @practice) }

    @user_exercise = @user.exercise
  }

  it "invalid user_exercise" do
    @user_exercise.invalid?.should == true
  end

  describe "build sentences" do
    before {
      @user_exercise.build_sentences(@practice)
    }

    describe "validate sentence_ids" do
      @user_exercise.sentence_ids.count.should == 10
    end

    describe "validate init_value" do
      before {
        @user_exercise.init_value
      }

      it "error_count" do
        @user_exercise.error_count.should == 0
      end

      it "done_count" do
        @user_exercise.done_count.should == 0
      end

      it "has_finished" do
        @user_exercise.has_finished.should == false
      end

      it "done_exam" do
        @user_exercise.done_exam.should == nil
      end

      it "exam" do
        JSON.parse(@user_exercise.exam).count.should == 10
      end
    end


    describe "validate refresh" do

      describe "false result" do
        before {
          @user_exercise.result = false
        }

        it "sentence not done" do
          @sentence.done_exam?.should == false
        end

        it "sentence done" do
          @user_exercise.refresh(@sentence)
          @user_exercise.done_exam?.should == true
        end

        it "failure count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@sentence.user_failure(@user).count}.by(1)
        end

        it "validate error count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@user_exercise.error_count}.by(1)
        end

        it "validate done count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@user_exercise.done_count}.by(1)
        end

        describe "validate has_finished?" do
          it "has_finished should be false" do
            @user_exercise.has_finished?.should == false
          end

          it "true" do
            @user_exercise.done_exam = @user_exercise.exam
            @user_exercise.refresh(@sentence)
            @user_exercise.has_finished?.should == true
          end
        end

      end

      describe "false result" do
        before {
          @user_exercise.result = true
        }

        it "sentence not done" do
          @sentence.done_exam?.should == false
        end

        it "sentence done" do
          @user_exercise.refresh(@sentence)
          @user_exercise.done_exam?.should == true
        end

        it "failure count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@sentence.user_failure(@user).count}.by(0)
        end

        it "validate error count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@user_exercise.error_count}.by(0)
        end

        it "validate done count" do
          expect{
            @user_exercise.refresh(@sentence)
          }.to change{@user_exercise.done_count}.by(1)
        end

        describe "validate has_finished?" do
          it "has_finished should be false" do
            @user_exercise.has_finished?.should == false
          end

          it "true" do
            @user_exercise.done_exam = @user_exercise.exam
            @user_exercise.refresh(@sentence)
            @user_exercise.has_finished?.should == true
          end
        end
        
      end

    end


    describe "validate points" do
      it "10 points" do
        expect{
          @user_exercise.error_count = 0
          @user_exercise.save
        }.to change{@user_exercise.point}.by(10)
      end

      it "1 points" do
        expect{
          @user_exercise.error_count = 1
          @user_exercise.save
        }.to change{@user_exercise.point}.by(1)
      end

      it "0 points" do
        expect{
          @user_exercise.error_count = (2..10).to_a.sample(1).first
          @user_exercise.save
        }.to change{@user_exercise.point}.by(0)
      end
    end

  end

  

end