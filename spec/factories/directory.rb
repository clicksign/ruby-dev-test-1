FactoryBot.define do
  factory :directory do
    factory :root_directory do
      name { "folder" }
      type {"Directory"}
    end
    factory :child_directory do
      name { "sub_folder" }
      type {"Directory"}
      association :parent, factory: :root_directory
    end
  end
end