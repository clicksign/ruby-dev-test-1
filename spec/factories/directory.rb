FactoryBot.define do
  factory :directory do
    name { Faker::Types.rb_string }
  end

  trait :main_directory do
    directory_id { nil }
  end
end