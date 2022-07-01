FactoryBot.define do
  factory :archive do
    name { 'Archive' }
    file { { io: File.open('README.md'), filename: 'readme' } }

    association :folder, strategy: :build
  end
end
