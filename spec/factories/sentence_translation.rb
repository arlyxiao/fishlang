FactoryGirl.define do
  factory :sentence_translation do
    sequence(:content){|n| "content_#{n}" }    
  end
end