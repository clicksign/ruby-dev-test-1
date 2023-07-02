FactoryBot.define do
  factory :user, class: User do
    email              { Faker::Internet.email }
    encrypted_password { Devise.friendly_token[0,20] }
  end
end
