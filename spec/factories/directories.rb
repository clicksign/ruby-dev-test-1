FactoryBot.define do
  factory :directory do
    name { FFaker::Filesystem.directory }
    ancestry { nil }

    trait :with_files do
      after(:build) do |directory|
        2.times do
          directory.files.attach(
            io: FFaker::Image.file,
            filename: FFaker::Filesystem.file_name(directory.name, FFaker::Lorem.word, 'png')
          )
        end
      end
    end
  end
end
