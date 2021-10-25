FactoryBot.define do
  factory :contract do
    user { create(:user) }
    description { Faker::Lorem.sentence(word_count: 20)}
    file { File.open(Rails.root.join('spec', 'fixtures', 'files', 'dummy.pdf')) }
  end
end
