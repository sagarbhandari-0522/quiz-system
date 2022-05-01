# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    question
    title { Faker::Lorem.word }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/myfile.jpg')) }
  end
end
