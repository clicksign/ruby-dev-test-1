# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it 'valid folder' do
    folder = build(:folder)

    expect(folder.save).to be_truthy
  end

  it 'not valid folder' do
    folder = build(:folder, name: nil)

    expect(folder.save).to be_falsey
  end

  it '#path' do
    root = create(:folder)
    parent = create(:folder, parent: root)
    children = create(:folder, parent: parent)

    expect(children.path).to eq([root, parent, children].map(&:name).join('/'))
  end
end
