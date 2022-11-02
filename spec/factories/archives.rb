# frozen_string_literal: true

FactoryBot.define do
  factory :archive do
    sequence(:name) { |n| "Arquivo-#{n}" }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/archives/amo_café.txt')) }
    directory
  end
end
