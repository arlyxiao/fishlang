FactoryGirl.define do
  factory :verb_tense do
    lesson
    sequence(:name){|n| "verb_#{n}" }

    sequence(:yo){|n| "name_#{n}" }
    sequence(:tu){|n| "name_#{n}" }
    sequence(:el){|n| "name_#{n}" }
    sequence(:ella){|n| "name_#{n}" }
    sequence(:usted){|n| "name_#{n}" }
    sequence(:nosotros){|n| "name_#{n}" }
    sequence(:nosotras){|n| "name_#{n}" }
    sequence(:vosotros){|n| "name_#{n}" }
    sequence(:vosotras){|n| "name_#{n}" }
    sequence(:ellos){|n| "name_#{n}" }
    sequence(:ellas){|n| "name_#{n}" }
    sequence(:ustedes){|n| "name_#{n}" }
  end
end