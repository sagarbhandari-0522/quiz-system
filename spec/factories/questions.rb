FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    trait :with_options do
      # option = build(:option, question: question)
      transient do
        option_count { 3 }
      end
      after(:build) do |question, evaluator|
        question.options << build_list(:option, evaluator.option_count, question: question)
      end
    end
    trait :with_categories do
      after(:build) do |question|
        question.categories << build_list(:category, 3)
      end
    end
    # trait :with_options do
    #   transient do
    #     title { 'Option 1' }
    # question { question }
    # end
    # end
  end
end
