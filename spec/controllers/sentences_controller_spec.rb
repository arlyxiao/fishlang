require 'spec_helper'

describe SentencesController do
  before {
    @user = FactoryGirl.create :user
    sign_in @user


    @practice = FactoryGirl.create :practice
    10.times do |i|
      s = FactoryGirl.create(:sentence, :practice => @practice)

      t = FactoryGirl.create(:sentence_translation, :sentence => s, :subject => 'test')
    end
    @user.build_sentences(@practice)
    
  }

  describe "validate user practice" do
    before {
      @user_practice = @user.get_practice(@practice)
    }

    it "error_count" do
      @user_practice.error_count.should == 0
    end

    it "exam" do
      JSON.parse(@user_practice.exam).count.should == 10
    end

    it "has_finished" do
      @user_practice.has_finished.should == false
    end

    it "points" do
      @user_practice.points.should == 0
    end

  end


  describe "#check, last sentence id" do
    before {
      sign_in @user
      @sentence_ids = @user.get_sentence_ids(@practice)
      @id = @sentence_ids[9]
      @sentence = Sentence.find(@id)
      @sentence_failure = @sentence.user_failure(@user)
    }

    it "correct failure count" do
      @sentence_failure.count.should == 0
    end


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @user_practice = @user.get_practice(@practice)
        @body = JSON::parse(response.body)
      }

      it "correct failure count" do
        @sentence_failure.count.should == 1
      end

      it "error_count should be correct" do
        @user_practice.error_count.should == 1
      end

      it "has_finished should be true" do
        @user_practice.has_finished.should == true
      end

      it "points should be correct" do
        @user_practice.points.should == 1
      end

      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == false
      end

    end

    describe "correct translation" do
      before {
        get 'check', :id => @id, :subject => 'test'
        @user_practice = @user.get_practice(@practice)
        @body = JSON::parse(response.body)
      }

      it "correct failure count" do
        @sentence_failure.count.should == 0
      end

      it "error_count should be correct" do
        @user_practice.error_count.should == 0
      end

      it "has_finished should be true" do
        @user_practice.has_finished.should == true
      end

      it "points should be correct" do
        @user_practice.points.should == 10
      end

      it "next_id should be correct" do
        @body['next_id'].should == nil
      end

      it "result should be correct" do
        @body['result'].should == true
      end

    end

    
  end




  describe "#check, other sentence id" do
    before {
      @sentence_ids = @user.get_sentence_ids(@practice)
      @id = @sentence_ids[1..8].sample(1).first
      @next_id = @sentence_ids[@sentence_ids.index(@id) + 1]
    }


    describe "incorrect translation" do

      before {
        get 'check', :id => @id, :subject => 'test subject'
        @user_practice = @user.get_practice(@practice)
        @body = JSON::parse(response.body)
      }

      it "error_count should be correct" do
        @user_practice.error_count.should == 1
      end

      it "has_finished should be true" do
        @user_practice.has_finished.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == false
      end

       
    end

    describe "correct translation" do

      before {
        get 'check', :id => @id, :subject => 'test'
        @user_practice = @user.get_practice(@practice)
        @body = JSON::parse(response.body)

        @error_count = @user_practice.error_count
        @done_count = @user_practice.done_count
        @done_exam = @user_practice.done_exam
      }

      it "error_count should be correct" do
        @user_practice.error_count.should == 0
      end

      it "has_finished should be true" do
        @user_practice.has_finished.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @next_id
      end

      it "result should be correct" do
        @body['result'].should == true
      end

      describe "go into check page again with correct answer" do
        before {
          get 'check', :id => @id, :subject => 'test'
          @user_practice = @user.get_practice(@practice)
          @sentence_failure = Sentence.find(@id).user_failure(@user)
        }

        it "same done_exam" do
          @user_practice.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_practice.done_count.should == @done_count
        end

        it "same error_count" do
          @user_practice.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
        end

      end

      describe "go into check page again with incorrect answer" do
        before {
          get 'check', :id => @id, :subject => 'test3333'
          @user_practice = @user.get_practice(@practice)
          @sentence_failure = Sentence.find(@id).user_failure(@user)
        }

        it "same done_exam" do
          @user_practice.done_exam.should == @done_exam
        end

        it "same done_count" do
          @user_practice.done_count.should == @done_count
        end

        it "same error_count" do
          @user_practice.error_count.should == @error_count
        end

        it "correct failure count" do
          @sentence_failure.count.should == 0
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

  end



  describe "validate user practice" do
    before {
      @user_practice = @user.get_practice(@practice)
      @exam = @user_practice.exam
    }

    it "nil done_exam" do
      @user_practice.done_exam.should be_nil
    end

    it "error_count" do
      @user_practice.error_count.should == 0
    end

    it "exam" do
      JSON.parse(@user_practice.exam).count.should == 10
    end

    it "has_finished" do
      @user_practice.has_finished.should == false
    end

    it "points" do
      @user_practice.points.should == 0
    end

    describe "validate the whole practice by sentences, correct answers" do
      before {
        @sentence_ids = @user.get_sentence_ids(@practice)
        @sentence_ids.each do |id|
          get 'check', :id => id, :subject => 'test'
        end
        @user_practice = @user.get_practice(@practice)
      }

      it "error_count" do
        @user_practice.error_count.should == 0
      end

      it "exam" do
        @user_practice.exam.should == @exam
      end

      it "has_finished" do
        @user_practice.has_finished.should == true
      end

      it "points" do
        @user_practice.points.should == 10
      end

      it "done_exam = exam" do
        @user_practice.done_exam.should == @user_practice.exam
      end

    end


    describe "validate the whole practice by sentences, incorrect answers" do
      before {
        @sentence_ids = @user.get_sentence_ids(@practice)
        @sentence_ids.each do |id|
          get 'check', :id => id, :subject => 'test111'
        end
        @user_practice = @user.get_practice(@practice)
      }

      it "error_count" do
        @user_practice.error_count.should == 10
      end

      it "exam" do
        @user_practice.exam.should == @exam
      end

      it "has_finished" do
        @user_practice.has_finished.should == true
      end

      it "points" do
        @user_practice.points.should == 0
      end


    end


    describe "validate the whole practice by sentences, incorrect with correct answers" do
      before {
        @sentence_ids = @user.get_sentence_ids(@practice)
        8.times do |i|
          get 'check', :id => @sentence_ids[i], :subject => 'test'
        end
        get 'check', :id => @sentence_ids[8], :subject => 'test1'
        get 'check', :id => @sentence_ids[9], :subject => 'test'

        @user_practice = @user.get_practice(@practice)
      }

      it "error_count" do
        @user_practice.error_count.should == 1
      end

      it "exam" do
        @user_practice.exam.should == @exam
      end

      it "has_finished" do
        @user_practice.has_finished.should == true
      end

      it "points" do
        @user_practice.points.should == 1
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