FactoryBot.define do
  factory :subdirectory do
    name { Faker::Lorem.word }
    directory { build(:directory) }

    after :build do |subdirectory|
      archive = open_archive_example
      archive2 = open_archive_example
      subdirectory.archives.attach(io: archive[:file],  filename: archive[:filename])
      subdirectory.archives.attach(io: archive2[:file], filename: archive2[:filename])
      subdirectory.save
    end
  end
end
