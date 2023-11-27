require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should belong_to :directory }
  it { should validate_presence_of :name }

  it 'is expected to validate that :content cannot be empty/false if :database storage_type' do
    document = build(:document, storage_type: :database)
    expect(document).to validate_presence_of(:content)
  end

  it 'is expected to validate that :content cannot be empty/false unless :database storage_type' do
    document = build(:document, storage_type: :s3)
    expect(document).to_not validate_presence_of(:content)
  end

  it do
    should define_enum_for(:storage_type).with_values(
      {
        database: 'database',
        disk: 'disk',
        s3: 's3'
      }
    ).backed_by_column_of_type(:string)
  end
end
