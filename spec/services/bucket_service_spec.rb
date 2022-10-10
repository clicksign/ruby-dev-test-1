# frozen_string_literal: true

RSpec.describe(BucketService, type: :service) do
  describe '.get_file' do
    let(:example_file_name) { example_file.basename }
    let(:key) { "test/#{example_file_name}" }
    let(:example_file) { Rails.root.join('spec/support/files/example.txt') }
    let(:temp_path) { Rails.root.join("storage/#{example_file_name}") }
    let(:result) { described_class.get_file(key) }

    before(:each) do
      bucket = described_class.bucket
      bucket.object(key).upload_file(example_file)
    end

    it 'return correct path' do
      expect(result).to(eq(temp_path))
    end

    it 'return same file' do
      expect(FileUtils.compare_file(result, temp_path)).to(ne(true))
    end
  end

  describe '.create_file' do
    let(:example_file) { Rails.root.join('spec/support/files/example.txt') }
    let(:result) { described_class.create_file!(example_file) }

    it 'return correct path' do
      expect(result).to(be_a(String))
    end
  end
end
