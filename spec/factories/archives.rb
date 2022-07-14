# frozen_string_literal: true

FactoryBot.define do
  factory :archive do
    name { Faker::Lorem.word }
    path { '/' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/lorem-ipsum.pdf')) }
    folder { nil }
  end
end
