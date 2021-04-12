FactoryBot.define do
  factory :directory do
    name { FFaker::Filesystem.directory }
    ancestry { nil }
  end
end
