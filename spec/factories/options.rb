# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    question
    title { Faker::Lorem.word }
  end
end
