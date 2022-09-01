FactoryBot.define do
  factory :file_directory do
    path { Faker::Lorem.word }

    trait :with_files do
      after :build do |file_directory|
        filename = "test.txt"
        tempfile = Tempfile.new(filename, encoding: "ascii-8bit")
        tempfile.write("test")
        tempfile.rewind
        file_directory.files.attach(io: File.open(tempfile), filename: filename, content_type: "text")
      end
    end
  end
end
