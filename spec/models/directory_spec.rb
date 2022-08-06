# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'validations' do
    subject { build(:directory) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:ancestry) }

    context 'with valid name' do
      subject { build(:directory, name: 'valid name') }

      it { is_expected.to be_valid }
    end

    context 'when name already exist in repository' do
      subject { build(:directory, name:) }

      let(:name) { 'name of repository' }
      let!(:directory) { create(:directory, name:) }

      it { is_expected.not_to be_valid }
    end

    context "should not start or end with space or contain '/'" do
      ['/invalid name', 'invalid name/', '  invalid name', 'invalid name   '].each do |name|
        subject { build(:directory, name:) }

        it "is expected #{name} not to be valid" do
          expect(subject).not_to be_valid
        end
      end
    end
  end

  describe 'callbacks' do
    subject { build(:directory, name:, slug: nil) }

    let(:name) { 'test name' }

    context 'build_slug' do
      it do
        subject.valid?

        expect(subject.slug).to eq(name.parameterize)
      end
    end
  end

  describe 'associations' do
    let(:directory) { directories.first.root }
    let(:directories) { create_list(:directory, 3, parent: create(:directory)) }

    context 'children' do
      subject { directory.children }

      it { is_expected.to match_array(directories) }
    end

    context 'descendants' do
      subject { directory.descendants }

      let(:sub_directories) do
        list = []

        directories.each do |directory_child|
          list << create_list(:directory, 3, parent: directory_child)
        end

        list.flatten
      end

      it { is_expected.to match_array(sub_directories + directories) }
    end
  end

  describe '#path' do
    let(:root) { create(:directory, name: 'root') }
    let(:children) { create(:directory, name: 'children', parent: root) }
    let(:descendant) { create(:directory, name: 'descendant', parent: children) }

    subject { descendant.path }

    it { is_expected.to eq('root/children/descendant') }
  end

  describe 'files' do
    let(:directory) { build(:directory) }
    let(:file) { File.open(file_fixture('file.json')) }

    before do
      directory.files.attach(
        io: file,
        filename: 'file.json',
        content_type: 'application/json'
      )
    end

    subject { directory.files }

    it { is_expected.to be_attached }
  end
end
