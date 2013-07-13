require "spec_helper"

describe UserExercise do
  before {
    @user = FactoryGirl.create(:user)
    @practice = FactoryGirl.create(:practice)

    12.times { @sentence = FactoryGirl.create(:sentence, :practice => @practice) }

    @user_exercise = @user.exercise
  }

  it "invalid user_exercise" do
    @user_exercise.nil?.should == true
  end

  describe "build exercise" do
    before {
      @user_exercise = @user.build_exercise(@practice)
    }

    it "valid exercise" do
      @user.exercise.valid?.should == true
    end

    it "validate sentence_ids" do
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
        @user_exercise.has_finished?.should == false
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
          @sentence.done_exam?(@user_exercise).should == false
        end

        it "sentence done" do
          @user_exercise.refresh(@sentence)
          @sentence.done_exam?(@user_exercise).should == true
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
            @user_exercise.save
            @user_exercise.refresh(@sentence).has_finished?.should == true
          end
        end

      end

      describe "false result" do
        before {
          @user_exercise.result = true
        }

        it "sentence not done" do
          @sentence.done_exam?(@user_exercise).should == false
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
            @user_exercise.save
            @user_exercise.refresh(@sentence).has_finished?.should == true
          end
        end
        
      end

    end


    describe "validate points" do
      describe "10 points" do
        before {
          @user_exercise.error_count = 0
          @user_exercise.save
        }

        it "points" do
          @user_exercise.points == 10
        end

        describe "not finished" do
          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(0)
          end
        end

        describe "finished" do
          before {
            @user_exercise.done_exam = @user_exercise.exam
            @user_exercise.save
          }

          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(10)
          end
        end
        
      end

      describe "1 points" do
        before {
          @user_exercise.error_count = 1
          @user_exercise.save
        }

        it "points" do
          @user_exercise.points == 1
        end

        describe "not finished" do
          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(0)
          end
        end

        describe "finished" do
          before {
            @user_exercise.done_exam = @user_exercise.exam
            @user_exercise.save
          }

          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(1)
          end
        end
        
      end

      describe "0 points" do
        before {
          @user_exercise.error_count = (2..10).to_a.sample(1).first
          @user_exercise.save
        }

        it "points" do
          @user_exercise.points == 0
        end

        describe "not finished" do
          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(0)
          end
        end

        describe "finished" do
          before {
            @user_exercise.done_exam = @user_exercise.exam
            @user_exercise.save
          }

          it "save points" do
            expect{
              @user_exercise.save_points(@practice)
            }.to change{@practice.user_points(@user).points}.by(0)
          end
        end

      end

    end

  end

  

end