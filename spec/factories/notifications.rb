# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { '' }
    params { '' }
    read_at { '2022-05-09 11:53:15' }
  end
end
