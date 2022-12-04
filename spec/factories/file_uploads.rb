# frozen_string_literal: true

FactoryBot.define do
  factory :file_upload do
    description { Faker::Lorem.sentence }
  end
end
