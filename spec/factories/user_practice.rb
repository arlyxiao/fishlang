FactoryGirl.define do
  factory :user_practice do
    user
    practice
    exam '2,9,10,1,8,4,7,3,6,5'
    error_count 0
    has_finished false
  end
end