FactoryBot.define do
  factory :archive do
    name { "new archive" }
    directory 

    transient do 
      data { 'image.jpg' }
    end

    trait :with_data do
      before(:create) do |archive, ev|
        data_path = File.join(Rails.root, '/spec/support/data', ev.data)
        archive.datas.attach(io: Rack::Test::UploadedFile.new(data_path, 'image/png'), filename: 'image.png')
      end
    end
  end
end
