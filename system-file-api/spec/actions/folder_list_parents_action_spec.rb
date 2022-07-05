# frozen_string_literal: true

require 'rails_helper'

describe FolderListParentsAction, type: :class do
  let(:parent_folder_one) { create(:folder) }
  let(:parent_folder_two) { create(:folder) }

  before do
    create_list(:folder, 2, folder_id: parent_folder_one.id)
    create_list(:folder, 2, folder_id: parent_folder_two.id)
  end

  it 'return only parent folders' do
    result = described_class.new.perform
    expect(result[:folders].length).to eq(2)
    expect(result[:folders].map(&:id)).to match([parent_folder_one.id, parent_folder_two.id])
  end
end
