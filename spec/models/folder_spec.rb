# == Schema Information
#
# Table name: folders
#
#  id             :uuid             not null, primary key
#  name           :string(300)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  main_folder_id :uuid
#
# Indexes
#
#  index_folders_on_main_folder_id  (main_folder_id)
#  index_folders_on_name            (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (main_folder_id => folders.id)
#
require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe '.validations' do
    context 'when valid' do
      subject(:folder) { build(:folder) }

      it { is_expected.to be_valid }

      context 'when use nested_attributes' do
        subject(:folder) { create(:folder, attributes_for_nested) }

        let(:sub_folders) { folder.sub_folders.reload }
        let(:attributes_for_nested) do
          {
            name: 'Level 1',
            sub_folders_attributes: [
              { name: 'Level 2' }
            ]
          }
        end

        it { is_expected.to be_valid }
        it { is_expected.to be_persisted }

        it { expect(folder.name).to eq(attributes_for_nested[:name]) }
        it { expect(sub_folders.first.name).to eq(attributes_for_nested[:sub_folders_attributes].first[:name]) }
        it { expect(sub_folders.count).to eq(attributes_for_nested[:sub_folders_attributes].count) }
      end
    end

    context 'when invalid' do
      context 'uniqueness' do
        subject(:folder) { build(:folder, name: old_folder.name) }

        let(:old_folder) { create(:folder, name: 'Example 1') }

        it { is_expected.to be_invalid }
      end

      context 'presence_of' do
        subject(:folder) { build(:folder) }

        it_behaves_like 'when not has value in attribute', 'name'
      end

      context 'string limit' do
        subject(:folder) { build(:folder, name: invalid_name) }

        let(:invalid_name) { ('a'..'z').to_a.sample * invalid_limiter }
        let(:invalid_limiter) { 301 }

        it { is_expected.to be_invalid }

        it 'when skip validate' do
          expect { subject.save(validate: false) }.to raise_error(ActiveRecord::ValueTooLong)
        end
      end
    end
  end

  describe 'relations' do
    context 'sub_folders' do
      subject(:sub_folders) { create(:folder, :with_sub_folders, sub_folders_count: size_of_subs).sub_folders }

      let(:size_of_subs) { 4 }

      it { expect(sub_folders).to be_kind_of(ActiveRecord::Associations::CollectionProxy) }
      it { expect(sub_folders.count).to eq(size_of_subs) }
    end
  end

  describe '.scopes' do
    context 'tree_folder' do
      subject(:tree_folder_scoped) { described_class.tree_folder(last_sub_folder.id) }

      let!(:folder) { create(:folder, attributes_for_nested) }
      let(:last_sub_folder) { described_class.find_by(name: 'Level 3') }
      let(:attributes_for_nested) do
        {
          name: 'Level 0',
          sub_folders_attributes: [
            {
              name: 'Level 1',
              sub_folders_attributes: [
                {
                  name: 'Level 2',
                  sub_folders_attributes: [
                    { name: 'Level 3' }
                  ]
                }
              ]
            }
          ]
        }
      end

      let(:names_expected) { Array.new(4) { |index| "Level #{index}" } }

      it { expect(tree_folder_scoped.pluck(:name)).to match_array(names_expected) }
    end
  end
end
