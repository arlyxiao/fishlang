FactoryGirl.define do
  factory :lesson do
    category
    sequence(:name){|n| "name_#{n}" }
  end
end