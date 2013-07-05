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
      @sentences = @user.get_sentences(@practice)
      @id = @sentences[9].id
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
      @sentences = @user.get_sentences(@practice)
      @id = @sentences[1].id
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
        @body['next_id'].should == @sentences[2].id
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
        @body['next_id'].should == @sentences[2].id
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
        @sentences = @user.get_sentences(@practice)
        @sentences.each do |s|
          get 'check', :id => s.id, :subject => 'test'
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
        @sentences = @user.get_sentences(@practice)
        @sentences.each do |s|
          get 'check', :id => s.id, :subject => 'test111'
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
        @sentences = @user.get_sentences(@practice)
        8.times do |i|
          get 'check', :id => @sentences[i].id, :subject => 'test'
        end
        get 'check', :id => @sentences[8].id, :subject => 'test1'
        get 'check', :id => @sentences[9].id, :subject => 'test'

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