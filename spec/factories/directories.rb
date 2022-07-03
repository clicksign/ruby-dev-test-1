FactoryBot.define do
  factory :directory do
    name { Faker::File.dir(segment_count: 1) }
    path { '/' }
    parent_id { 1 }
  end
end