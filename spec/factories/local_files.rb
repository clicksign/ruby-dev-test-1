FactoryBot.define do
  factory :local_file do
    name { Faker::Name.unique }
    attached { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'files', 'sample.pdf')) }
  end
end
