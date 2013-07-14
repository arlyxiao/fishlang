require 'spec_helper'

# test practice
describe SentencesController do
  before {
    @user = FactoryGirl.create :user
    sign_in @user


    @practice = FactoryGirl.create :practice
    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')
    end
    @user_exercise = @user.build_exercise(@practice)

    session[:current_type] = 'practice'
    session[:practice_id] = @practice.id
    
  }



  describe "#check, last sentence id" do
    before {
      @sentence_ids = @user_exercise.sentence_ids
      @id = @sentence_ids[9]
      @sentence_failure = Sentence.find(@id).user_failure(@user)
    }

    it "correct failure count" do
      @sentence_failure.count.should == 0
    end


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "correct failure count" do
        @sentence_failure.reload
        @sentence_failure.count.should == 1
      end

      it "error_count should be correct" do
        @user_exercise.error_count.should == 1
      end

      it "has_finished? should be false" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == false
      end

      it "points" do
        @practice.user_points(@user).points.should == 0
      end

    end

    describe "correct translation" do
      before {
        get 'check', :id => @id, :subject => 'test'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "correct failure count" do
        @sentence_failure.count.should == 0
      end

      it "error_count should be correct" do
        @user_exercise.error_count.should == 0
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end


      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == true
      end

      it "points" do
        @practice.user_points(@user).points.should == 0
      end

    end

    
  end




  describe "#check, other sentence id" do
    before {
      @sentence_ids = @user_exercise.sentence_ids
      @id = @sentence_ids[1..8].sample(1).first
      @next_id = @sentence_ids[@sentence_ids.index(@id) + 1]
    }


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "error_count should be correct" do
        @user_exercise.error_count.should == 1
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == false
      end

      it "points" do
        @practice.user_points(@user).points.should == 0
      end

       
    end

    describe "correct translation" do

      before {
        get 'check', :id => @id, :subject => 'test'
        @body = JSON::parse(response.body)

        @error_count = @user_exercise.error_count
        @done_count = @user_exercise.done_count
        @done_exam = @user_exercise.done_exam
      }

      it "error_count should be correct" do
        @user_exercise.error_count.should == 0
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == true
      end

      it "points" do
        @practice.user_points(@user).points.should == 0
      end

      describe "go into check page again with correct answer" do
        before {
          get 'check', :id => @id, :subject => 'test'
          @sentence_failure = Sentence.find(@id).user_failure(@user)
        }

        it "same done_exam" do
          @user_exercise.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_exercise.done_count.should == @done_count
        end

        it "same error_count" do
          @user_exercise.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
        end

        it "points" do
          @practice.user_points(@user).points.should == 0
        end

      end

      describe "go into check page again with incorrect answer" do
        before {
          get 'check', :id => @id, :subject => 'test3333'
          @sentence_failure = Sentence.find(@id).user_failure(@user)
          @user_exercise = @user.exercise
        }

        it "same done_exam" do
          @user_exercise.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_exercise.done_count.should == @done_count
        end

        it "same error_count" do
          @user_exercise.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
        end

        it "points" do
          @practice.user_points(@user).points.should == 0
        end

      end

    end

    
  end


  describe "#check any sentence id not in the exam" do
    before {
      @sentence = FactoryGirl.create(:sentence, :practice => @practice)
      @sentence_failure = @sentence.user_failure(@user)

      get 'check', :id => @sentence.id, :subject => 'test subject'
      @result = response.body
    }

    it "empty response" do
      @result.should == 'null'
    end

    it "correct failure count" do
      @sentence_failure.count.should == 0
    end

    it "points" do
      @practice.user_points(@user).points.should == 0
    end

  end



  describe "validate user exercise" do
    before {
      @exam = @user_exercise.exam
    }

    it "nil done_exam" do
      @user_exercise.done_exam.should be_nil
    end

    it "error_count" do
      @user_exercise.error_count.should == 0
    end

    it "exam" do
      JSON.parse(@user_exercise.exam).count.should == 10
    end

    it "has_finished?" do
      @user_exercise.has_finished?.should == false
    end

    it "kind" do
      @user_exercise.kind.should == 'practice'
    end

    it "empty failures" do
      SentenceFailure.all.count.should == 0
    end


    describe "validate the whole practice by sentences, correct answers" do

      describe "practice" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id|
            get 'check', :id => id, :subject => 'test'
          end
          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 0
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @practice.user_points(@user).points.should == 10
        end

        it "empty failures" do
          SentenceFailure.all.each do |f|
            f.count.should == 0
            f.correct_count.should == 0
          end
        end
      end    

    end


    describe "validate the whole practice by sentences, incorrect answers" do

      describe "practice" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id| 
            get 'check', :id => id, :subject => 'test111'
          end

          @failures = SentenceFailure.all

          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 10
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
           @practice.user_points(@user).points.should == 0
        end

        it "failures" do
          @failures.each do |f|
            f.count.should == 1
            f.correct_count.should == 0
          end
        end

      end

    end


    describe "validate the whole practice by sentences, incorrect and correct answers" do

      describe "practice" do
        before {
          
          @sentence_ids = @user_exercise.sentence_ids
          8.times do |i|
            get 'check', :id => @sentence_ids[i], :subject => 'test'
          end
          get 'check', :id => @sentence_ids[8], :subject => 'test1'
          get 'check', :id => @sentence_ids[9], :subject => 'test'

          @user_exercise.reload

        }

        it "error_count" do
          @user_exercise.error_count.should == 1
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @practice.user_points(@user).points.should == 1
        end
      end

    end


  end

end


# test lesson
describe SentencesController do
  before {
    @user = FactoryGirl.create :user
    sign_in @user

    @lesson = FactoryGirl.create :lesson
    @practice_1 = FactoryGirl.create :practice, :lesson => @lesson
    @practice_2 = FactoryGirl.create :practice, :lesson => @lesson

    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice_1)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')
    end

    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice_2)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')
    end

    @user_exercise = @user.build_exercise(@lesson)

    session[:current_type] = 'lesson'
    session[:lesson_id] = @lesson.id
    
  }



  describe "#check, last sentence id" do
    before {
      @sentence_ids = @user_exercise.sentence_ids
      @id = @sentence_ids[9]
      @sentence_failure = Sentence.find(@id).user_failure(@user)
    }

    it "correct failure count" do
      @sentence_failure.count.should == 0
    end


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "correct failure count" do
        @sentence_failure.reload
        @sentence_failure.count.should == 1
      end

      it "error_count should be correct" do
        @user_exercise.error_count.should == 1
      end

      it "has_finished? should be false" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == false
      end

      it "points" do
        @lesson.user_points(@user).points.should == 0
      end

    end

    describe "correct translation" do
      before {
        get 'check', :id => @id, :subject => 'test'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "correct failure count" do
        @sentence_failure.count.should == 0
      end

      it "error_count should be correct" do
        @user_exercise.error_count.should == 0
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end


      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == true
      end

      it "points" do
        @lesson.user_points(@user).points.should == 0
      end

    end

    
  end




  describe "#check, other sentence id" do
    before {
      @sentence_ids = @user_exercise.sentence_ids
      @id = @sentence_ids[1..8].sample(1).first
      @next_id = @sentence_ids[@sentence_ids.index(@id) + 1]
    }


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @body = JSON::parse(response.body)
        @user_exercise.reload
      }

      it "error_count should be correct" do
        @user_exercise.error_count.should == 1
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == false
      end

      it "points" do
        @lesson.user_points(@user).points.should == 0
      end

       
    end

    describe "correct translation" do

      before {
        get 'check', :id => @id, :subject => 'test'
        @body = JSON::parse(response.body)

        @error_count = @user_exercise.error_count
        @done_count = @user_exercise.done_count
        @done_exam = @user_exercise.done_exam
      }

      it "error_count should be correct" do
        @user_exercise.error_count.should == 0
      end

      it "has_finished? should be true" do
        @user_exercise.has_finished?.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == true
      end

      it "points" do
        @lesson.user_points(@user).points.should == 0
      end

      describe "go into check page again with correct answer" do
        before {
          get 'check', :id => @id, :subject => 'test'
          @sentence_failure = Sentence.find(@id).user_failure(@user)
        }

        it "same done_exam" do
          @user_exercise.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_exercise.done_count.should == @done_count
        end

        it "same error_count" do
          @user_exercise.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
        end

        it "points" do
          @lesson.user_points(@user).points.should == 0
        end

      end

      describe "go into check page again with incorrect answer" do
        before {
          get 'check', :id => @id, :subject => 'test3333'
          @sentence_failure = Sentence.find(@id).user_failure(@user)
          @user_exercise = @user.exercise
        }

        it "same done_exam" do
          @user_exercise.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_exercise.done_count.should == @done_count
        end

        it "same error_count" do
          @user_exercise.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
        end

        it "points" do
          @lesson.user_points(@user).points.should == 0
        end

      end

    end

    
  end


  describe "#check any sentence id not in the exam" do
    before {
      @sentence = FactoryGirl.create(:sentence, :practice => @practice_1)
      @sentence_failure = @sentence.user_failure(@user)

      get 'check', :id => @sentence.id, :subject => 'test subject'
      @result = response.body
    }

    it "empty response" do
      @result.should == 'null'
    end

    it "correct failure count" do
      @sentence_failure.count.should == 0
    end

    it "points" do
      @lesson.user_points(@user).points.should == 0
    end

  end



  describe "validate user exercise" do
    before {
      @exam = @user_exercise.exam
    }

    it "nil done_exam" do
      @user_exercise.done_exam.should be_nil
    end

    it "error_count" do
      @user_exercise.error_count.should == 0
    end

    it "exam" do
      JSON.parse(@user_exercise.exam).count.should == 10
    end

    it "has_finished?" do
      @user_exercise.has_finished?.should == false
    end

    it "kind" do
      @user_exercise.kind.should == 'lesson'
    end


    describe "validate the whole practice by sentences, correct answers" do

      describe "lesson" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id|
            get 'check', :id => id, :subject => 'test'
          end
          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 0
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @lesson.user_points(@user).points.should == 10
        end
      end    

    end


    describe "validate the whole practice by sentences, incorrect answers" do

      describe "lesson" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id| 
            get 'check', :id => id, :subject => 'test111'
          end
          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 10
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @lesson.user_points(@user).points.should == 0
        end
      end

    end


    describe "validate the whole lesson by sentences, incorrect and correct answers" do

      describe "lesson" do
        before {
          
          @sentence_ids = @user_exercise.sentence_ids
          8.times do |i|
            get 'check', :id => @sentence_ids[i], :subject => 'test'
          end
          get 'check', :id => @sentence_ids[8], :subject => 'test1'
          get 'check', :id => @sentence_ids[9], :subject => 'test'

          @user_exercise.reload

        }

        it "error_count" do
          @user_exercise.error_count.should == 1
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @lesson.user_points(@user).points.should == 1
        end
      end

    end


  end

end


# test sentence failure
describe SentencesController do

  before {
    @user = FactoryGirl.create :user
    sign_in @user

    @lesson = FactoryGirl.create :lesson
    @practice_1 = FactoryGirl.create :practice, :lesson => @lesson
    @practice_2 = FactoryGirl.create :practice, :lesson => @lesson

    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice_1)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')

      FactoryGirl.create(:sentence_failure, :sentence => s, :user => @user, :count => 2)
    end

    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice_2)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')

      @failure = FactoryGirl.create(:sentence_failure, :sentence => s, :user => @user, :count => 3)
    end

    @user_exercise = @user.build_exercise(@failure)

    session[:current_type] = 'sentence_failure'    
  }

  describe "validate user exercise" do
    before {
      @exam = @user_exercise.exam
    }

    it "has_finished?" do
      @user_exercise.has_finished?.should == false
    end

    it "kind" do
      @user_exercise.kind.should == 'sentencefailure'
    end


    describe "validate the whole practice by sentences, correct answers" do

      describe "sentence failure" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id|
            get 'check', :id => id, :subject => 'test'
          end
          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 0
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do

          @failure.user_points(@user).points.should == 10

        end
      end    

    end


    describe "validate the whole practice by sentences, incorrect answers" do

      describe "sentence_failure" do
        before {

          @sentence_ids = @user_exercise.sentence_ids
          @sentence_ids.each do |id| 
            get 'check', :id => id, :subject => 'test111'
          end
          @user_exercise.reload
        }

        it "error_count" do
          @user_exercise.error_count.should == 10
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @failure.user_points(@user).points.should == 0
        end
      end

    end


    describe "validate the whole sentences, incorrect and correct answers" do

      describe "sentence_failure" do
        before {
          
          @sentence_ids = @user_exercise.sentence_ids
          8.times do |i|
            get 'check', :id => @sentence_ids[i], :subject => 'test'
          end
          get 'check', :id => @sentence_ids[8], :subject => 'test1'
          get 'check', :id => @sentence_ids[9], :subject => 'test'

          @user_exercise.reload

        }

        it "error_count" do
          @user_exercise.error_count.should == 1
        end

        it "exam" do
          @user_exercise.exam.should == @exam
        end

        it "has_finished?" do
          @user_exercise.has_finished?.should == true
        end

        it "points" do
          @failure.user_points(@user).points.should == 1
        end
      end

    end


  end
end



describe SentencesController do

  describe "report sentence exam errors" do

    before {
      @user = FactoryGirl.create :user
      sign_in @user

      @s = FactoryGirl.create(:sentence)

      post 'report', :id => @s.id, :user_answer => 'test user answer', :content => 'test content'

      @r = @user.sentence_reports.first
    }

    it "user" do
      @r.user.should == @user
    end

    it "user_answer" do
      @r.user_answer.should == 'test user answer'
    end

    it "content" do
      @r.content.should == 'test content'
    end

    it "sentence" do
      @r.sentence.should == @s
    end

  end

  
end