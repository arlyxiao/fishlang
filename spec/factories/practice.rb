FactoryGirl.define do
  factory :practice do
    lesson
    sequence(:name){|n| "name_#{n}" }
  end
end