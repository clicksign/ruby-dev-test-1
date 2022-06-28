FactoryBot.define do
  factory :archive do
    name { SecureRandom.hex}
    file { Rack::Test::UploadedFile.new('spec/fixtures/test.yml', 'application/x-yaml') }

    association :folder
  end
end