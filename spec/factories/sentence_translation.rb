FactoryGirl.define do
  factory :sentence_translation do
    sequence(:subject){|n| "content_#{n}" }    
  end
end