FactoryGirl.define do
  factory :sentence do
    sequence(:subject){|n| "content_#{n}" }    
  end
end