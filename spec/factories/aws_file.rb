FactoryBot.define do
  factory :aws_file do
    name { Faker::Lorem.word }
    path { Faker::Lorem.word }
    url { Faker::Internet.url }
    association :directory
  end
end
