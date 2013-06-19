FactoryGirl.define do
  factory :sentence do
    sequence(:content){|n| "content_#{n}" }    
  end
end