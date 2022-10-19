# This will guess the User class
FactoryBot.define do
  factory :document do
    name { 'New Document' }
    content { 'This is the content for the new document' }
    association :folder
  end
end
