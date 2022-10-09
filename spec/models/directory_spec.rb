# frozen_string_literal: true

RSpec.describe(Directory, type: :model) do
  let(:root_directory) { described_class.top_level.first }

  describe 'associations' do
    let(:directory) { build(:directory) }

    it do
      expect(directory).to(
        have_many(:children)
          .class_name('Directory')
          .with_foreign_key('parent_id')
          .inverse_of(false)
          .dependent(:destroy)
      )
    end
  end

  describe 'validations' do
    it { is_expected.to(validate_presence_of(:name)) }
  end

  describe 'scopes' do
    describe '.top_level' do
      let(:top_level) { described_class.top_level.first }

      it 'return root directory' do
        expect(top_level.name).to(eq('root'))
      end
    end
  end

  describe '#self_and_descendents' do
    let(:directory) { create(:directory, parent: root_directory) }
    let(:childrens) { create_list(:directory, 2, parent: directory) }
    let(:expected) do
      childrens.prepend(directory)
    end

    it 'return directory with descendents' do
      expect(directory.self_and_descendents).to(eq(expected))
    end
  end
end
