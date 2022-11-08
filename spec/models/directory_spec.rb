# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory do
  subject(:directory) { create(:directory) }

  it { expect(directory).to(be_valid) }

  describe 'associations' do
    it { expect(directory).to(belong_to(:parent).class_name('Directory').optional(true)) }
    it { expect(directory).to(have_many(:subdirectories).class_name('Directory').dependent(:destroy)) }
    it { expect(directory).to(have_many(:documents).dependent(:destroy)) }
  end

  describe 'validations' do
    it { expect(directory).to(validate_presence_of(:name)) }
    it { expect(directory).to(validate_uniqueness_of(:name).scoped_to(:parent_id)) }
  end

  describe 'getters' do
    let(:file_size) { directory.documents.includes(:content_blob).sum(&:size) }
    let(:directory_name) { directory.name }

    describe '#path' do
      it { expect(directory.path).to(eq("/#{directory_name}")) }
    end

    describe '#size' do
      it { expect(directory.size).to(eq(file_size)) }
    end
  end

  describe 'when directory has a parent' do
    subject(:directory_with_parent) { create(:directory, :with_parent) }

    let(:directory_name) { directory_with_parent.name }

    describe '#path' do
      it { expect(directory_with_parent.path).to(eq("#{directory_with_parent.parent.path}/#{directory_name}")) }
    end
  end

  describe 'when directory has subdirectories' do
    subject(:directory_with_subdirectories) { create(:directory, :with_subdirectories) }

    let(:folder_documents_size) { directory_with_subdirectories.documents.includes(:content_blob).sum(&:size) }

    describe '#size' do
      it { expect(directory_with_subdirectories.size).to(be > folder_documents_size) }
    end
  end
end
