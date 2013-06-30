FactoryGirl.define do
  sequence(:num) {|n| n}

  factory :user do
    name     {"u#{generate(:num)}"}
    email    {"u#{generate(:num)}@fishlang.com"}
    password '111111'
    
  end

end