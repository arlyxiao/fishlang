FactoryGirl.define do
  factory :sentence do
  	practice
    sequence(:subject){|n| "content_#{n}" }
    sequence(:verb){|n| "verb_#{n}" }
  end
end