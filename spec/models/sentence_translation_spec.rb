require "spec_helper"

describe SentenceTranslation do
  before {
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)

    @lesson = FactoryGirl.create(:lesson)

    @practice_1 = FactoryGirl.create(:practice, :lesson => @lesson)
    @practice_2 = FactoryGirl.create(:practice, :lesson => @lesson)

    
  }


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




  describe "Validate translate" do

    before {
      @sentence = Sentence.find(7)
    }

    describe "Without additional spaces among words" do
      before {
        @subject_1 = "Lo podemos lograr juntos"
        @subject_2 = 'nosotros podemos lograrlo juntos '
        @subject_3 = 'nosotras podemos lograrlo    juntos '
        @subject_4 = 'podemos lograrlo juntos nosotras podemos'
        @subject_5 = ' yo podemos lograrlo juntos '
      }

      it "sentence translation(1) should be correct" do
        @sentence.translate?(@subject_1).should == true
      end

      it "sentence translation(2) should be correct" do
        @sentence.translate?(@subject_2).should == true
      end

      it "sentence translation(3)" do
        @sentence.translate?(@subject_3).should == true
      end

      it "sentence translation(4)" do
        @sentence.translate?(@subject_4).should == false
      end

      it "sentence translation(5)" do
        @sentence.translate?(@subject_5).should == false
      end

    end


  end

  describe "Validate translate" do

    before {
      @sentence = Sentence.find(1)
    }

    describe "with no" do
      before {
        @subject_1 = "En este momento yo no puedo volver"
        @subject_2 = 'En este momento no puedo volver'
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