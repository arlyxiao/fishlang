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
      @user_practice.exam.split(',').count.should == 10
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
      @id = @sentence_ids[1]
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
        @body['next_id'].should == @sentence_ids[2]
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

      it "error_count should be correct" do
        @user_practice.error_count.should == 0
      end

      it "has_finished should be true" do
        @user_practice.has_finished.should == false
      end

      it "next_id should be correct" do
        @body['next_id'].should == @sentence_ids[2]
      end

      it "result should be correct" do
        @body['result'].should == true
      end

    end

    
  end


  describe "validate user practice" do
    before {
      @user_practice = @user.get_practice(@practice)
      @exam = @user_practice.exam
    }

    it "error_count" do
      @user_practice.error_count.should == 0
    end

    it "exam" do
      @user_practice.exam.split(',').count.should == 10
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