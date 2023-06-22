# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archive, type: :model do
  it { should validate_presence_of(:file) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(60) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it '#path' do
    folder = create(:folder)
    archive = create(:archive, :with_file, folder: folder)

    expect(archive.path).to eq([folder, archive].map(&:name).join('/'))
  end
end
