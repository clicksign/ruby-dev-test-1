FactoryBot.define do
  factory :local_file do
    name { "file.ext" }
    type {"LocalFile"}
    association :parent, factory: :child_directory
  end
end