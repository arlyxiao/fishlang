FactoryGirl.define do
  factory :lesson_point do
    lesson
    user
    points 0
  end
end