# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    trait :with_questions do
      after(:build) do |category|
        category.questions << build_list(:question, 3)
      end
    end
    after(:create) do |category|
      category.questions << build_list(:question, 5, :with_options)
    end
  end
end
