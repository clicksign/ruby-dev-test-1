FactoryBot.define do
  factory :directory do
    name { Faker::Fantasy::Tolkien.character }
  end
end
