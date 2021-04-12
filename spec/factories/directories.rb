FactoryBot.define do
  factory :directory do
    name { FFaker::Filesystem.directory }
    ancestry { nil }

    trait :with_file do
      after(:build) do |directory|
        path = Rails.root.join('spec', 'fixtures', 'files', 'sample.txt')
        directory.files.attach(io: File.open(path), filename: 'sample.txt', content_type: 'text/plain')
      end
    end
  end
end
