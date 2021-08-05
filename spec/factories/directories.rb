FactoryBot.define do
  sequence :name do |i|
    "directory#{i}"
  end
  factory :directory do
    name { generate(:name) }
  end
end
