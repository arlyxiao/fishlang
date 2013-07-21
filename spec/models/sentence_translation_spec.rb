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
      @verb_tense = FactoryGirl.create(:verb_tense, 
        :name => 'poder', 
        :lesson => @lesson,

        :yo => "puedo",
        :tu => "puedes",
        :el => "puede",
        :ella => "puede",
        :usted => "puede",
        :nosotros => "podemos",
        :nosotras => "podemos",
        :vosotros => "podeís",
        :vosotras => "podeís",
        :ellos => "pueden",
        :ellas => "pueden",
        :ustedes => "pueden",
      )
    }


    describe "lo" do

      before {

        @sentence = FactoryGirl.create(:sentence, 
          :subject => 'we can do it this time', 
          :verb => 'poder',
          :verb_tense => @verb_tense
        )

        @sentence_translation_1 = FactoryGirl.create(:sentence_translation,
          :sentence => @sentence,
          :subject => "podemos hacerlo este tiempo"
        )

        @sentence_translation_2 = FactoryGirl.create(:sentence_translation,
          :sentence => @sentence,
          :subject => "Este tiempo podemos hacerlo"
        )

        @sentence_translation_3 = FactoryGirl.create(:sentence_translation,
          :sentence => @sentence,
          :subject => "Este tiempo lo podemos hacer"
        )

        @sentence_translation_3 = FactoryGirl.create(:sentence_translation,
          :sentence => @sentence,
          :subject => "lo podemos hacer este tiempo"
        )
      }

      describe "user translation" do
        before {
          @subject_1 = "nosotros podemos hacerlo este tiempo"
          @subject_2 = 'Nosotras podemos hacerlo este tiempo'
          @subject_3 = 'Nosotras lo podemos hacer este tiempo'
          @subject_4 = 'este tiempo Nosotras lo podemos hacer'
          @subject_5 = ' este tiempo     Nosotras podemos hacerlo '


          @subject_6 = 'Nosotras la podemos hacer este tiempo'
        }

        it "sentence translation(1) should be correct" do
          @sentence.translate?(@subject_1).should == true
        end

        it "sentence translation(2) should be correct" do
          @sentence.translate?(@subject_2).should == true
        end

        it "sentence translation(3) should be correct" do
          @sentence.translate?(@subject_3).should == true
        end

        it "sentence translation(4) should be correct" do
          @sentence.translate?(@subject_4).should == true
        end

        it "sentence translation(5) should be correct" do
          @sentence.translate?(@subject_5).should == true
        end

        it "sentence translation(6) should be correct" do
          @sentence.translate?(@subject_6).should == false
        end


      end

    end


    describe "la, te, me" do
      before {

        @sentence = FactoryGirl.create(:sentence, 
          :subject => 'she can him', 
          :verb => 'poder',
          :verb_tense => @verb_tense
        )

        
      }

      describe "la" do
        before {
          @sentence_translation_1 = FactoryGirl.create(:sentence_translation,
            :sentence => @sentence,
            :subject => "ella la puede"
          )
          @subject_1 = "la puede"

        }

        it "sentence translation(1)" do
          @sentence.translate?(@subject_1).should == true
        end
      end

      describe "te" do
        before {
          @sentence_translation_1 = FactoryGirl.create(:sentence_translation,
            :sentence => @sentence,
            :subject => "ella te puede"
          )
          @subject_1 = "te puede"

        }

        it "sentence translation(1)" do
          @sentence.translate?(@subject_1).should == true
        end
      end

      describe "me" do
        before {
          @sentence_translation_1 = FactoryGirl.create(:sentence_translation,
            :sentence => @sentence,
            :subject => "ella me puede"
          )
          @subject_1 = "me puede"

        }

        it "sentence translation(1)" do
          @sentence.translate?(@subject_1).should == true
        end
      end


      describe "no me" do
        before {
          @sentence_translation_1 = FactoryGirl.create(:sentence_translation,
            :sentence => @sentence,
            :subject => "ella no me puede"
          )
          @subject_1 = "no me puede"
          @subject_2 = "me no puede"

        }

        it "sentence translation(1)" do
          @sentence.translate?(@subject_1).should == true
        end

        it "sentence translation(2)" do
          @sentence.translate?(@subject_2).should == false
        end
      end

    end


  end


end