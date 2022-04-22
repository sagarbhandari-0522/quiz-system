FactoryBot.define do
  factory :option do
    question
    title { Faker::Lorem.word }
  end
end
