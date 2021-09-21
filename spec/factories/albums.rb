FactoryBot.define do
  factory :album do
    name { Faker::Name.name }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec/support/assets/madona.png")) }
  end
end
