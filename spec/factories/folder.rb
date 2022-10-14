FactoryBot.define do
  factory :folder, class: 'Folder' do
    name { Faker::Name.name }
    parent_id { nil }
  end
end
