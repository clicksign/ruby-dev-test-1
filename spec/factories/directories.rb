FactoryBot.define do
  factory :directory do
    name { Faker::Lorem.word }

    after :build do |directory|
      archive = open_archive_example
      archive2 = open_archive_example
      directory.archives.attach(io: archive[:file],  filename: archive[:filename])
      directory.archives.attach(io: archive2[:file], filename: archive2[:filename])
      directory.save
    end
  end
end
