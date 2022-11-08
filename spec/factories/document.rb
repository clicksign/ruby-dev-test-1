FactoryBot.define do
  factory :document do
    content { Rack::Test::UploadedFile.new(Rails.root.join("test", "fixtures", "files", "document.png"), "image/png") }
    association :directory
  end
end
