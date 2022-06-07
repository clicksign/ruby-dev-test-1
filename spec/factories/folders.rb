FactoryBot.define do
  factory :folder do
    name { "MyString" }
    permission { 777 }
  end

  trait :with_sub_folders do
    after(:create)  do |folder|
      folder.sub_folders = create_list(:folder, 3)
    end
  end
end
