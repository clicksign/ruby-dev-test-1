# frozen_string_literal: true

FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }
    path { '/' }
    parent { nil }
    archives { [] }
  end
end
