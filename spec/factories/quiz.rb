# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    user_answer { %w[1 2 3 4 5] }
    score { Faker::Number.number(digits: 2) }
    percentage { Faker::Number.decimal(l_digits: 2) }
    trait :with_questions do
      after(:build) do |quiz|
        quiz.questions << build_list(:question, 5)
      end
    end
    trait :with_categories do
      after(:build) do |quiz|
        quiz.categories << build_list(:category, 2)
      end
    end
    trait :with_user do
      after(:build) do |quiz|
        quiz.user = build(:user)
      end
    end
  end
end
