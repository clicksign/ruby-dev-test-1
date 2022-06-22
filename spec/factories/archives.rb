FactoryBot.define do
  factory :archive do
    name { Faker::Fantasy::Tolkien.character }
    file { fixture_file_upload('file.txt') }

    association :directory
  end
end
