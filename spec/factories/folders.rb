require 'faker'

FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }
  end
end
