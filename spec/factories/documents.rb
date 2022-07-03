FactoryBot.define do
  factory :document do
    file { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/resume.pdf'))) }
    name { 'resume.pdf' }
    ext { 'pdf' }
    size { Faker::Number.decimal(l_digits: 2) }
    path { Faker::File.dir(segment_count: 1) }
    directory_id { 1 }
  end
end