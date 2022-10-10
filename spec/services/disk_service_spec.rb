# frozen_string_literal: true

RSpec.describe(DiskService, type: :service) do
  describe '.get_file' do
    let(:example_file) { 'spec/support/files/example.txt' }
    let(:path) { Rails.root.join(example_file) }
    let(:result) { described_class.get_file(example_file) }

    it 'return correct path' do
      expect(result).to(eq(path))
    end

    it 'return same file' do
      expect(FileUtils.compare_file(result, path)).to(be(true))
    end
  end

  describe '.create_file' do
    context 'when receiving Pathname' do
      let(:example_file) { Rails.root.join('spec/support/files/example.txt') }
      let(:result) { described_class.create_file!(example_file) }

      it 'return type' do
        expect(result).to(be_a(Pathname))
      end

      it 'return correct path' do
        expect(result.to_s).to(match(/_example.txt/))
      end
    end

    context 'when receiving File' do
      let(:example_file) { Rails.root.join('spec/support/files/example.txt').open }
      let(:result) { described_class.create_file!(example_file) }

      it 'return type' do
        expect(result).to(be_a(Pathname))
      end

      it 'return correct path' do
        expect(result.to_s).to(match(/_example.txt/))
      end
    end
  end
end
