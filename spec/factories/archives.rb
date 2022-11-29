FactoryBot.define do
  factory :archive do
    sequence(:name) { |n| "archive-#{n}" }
    file { Rack::Test::UploadedFile.new(Rails.root.join('public/files/ransoware.txt')) }
    directory
  end
end