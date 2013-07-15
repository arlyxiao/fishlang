require 'spec_helper'


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