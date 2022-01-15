FactoryBot.define do
    factory :folder do
        name { 'folder1' }
        parent_id { nil }
        childrens { [] }
        assets { [] }
    end
  end