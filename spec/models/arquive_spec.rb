# frozen_string_literal: true

RSpec.describe(Arquive, type: :model) do
  describe 'associations' do
    it { is_expected.to(belong_to(:directory)) }
  end

  describe 'with invalid params' do
    let(:arquive) { build(:arquive, persistence: :invalid) }

    it 'raise an error' do
      expect { arquive.save! }.to(raise_error(ArgumentError))
    end
  end

  describe 'with empty required params' do
    let(:arquive) { build(:arquive, name: nil) }

    it 'raise an error' do
      expect { arquive.save! }.to(raise_error(ActiveRecord::RecordInvalid))
    end
  end

  describe '.create' do
    context 'with persistence to database' do
      let(:arquive) { build(:arquive, persistence: :database) }

      before(:each) do
        arquive.save
      end

      it 'correct save file' do
        expect(arquive).to(be_persisted)
      end

      it 'do not save a path' do
        expect(arquive.path).not_to(be_present)
      end

      it 'return correct file' do
        expect(arquive.file).to(be_present)
        expect(arquive.file).to(be_a(Pathname))
      end

      it 'compare file contents' do
        original_file = Rails.root.join('storage/example.txt')
        created_file = Rails.root.join(arquive.file)

        expect(FileUtils.compare_file(original_file, created_file)).to(be(true))
      end
    end

    context 'with persistence to local' do
      let(:arquive) { build(:arquive, persistence: :local) }

      before(:each) do
        arquive.save
      end

      it 'correct save file' do
        expect(arquive).to(be_persisted)
      end

      it 'correct save a path' do
        expect(arquive.path).to(be_present)
      end

      it 'return correct file' do
        expect(arquive.file).to(be_present)
        expect(arquive.file).to(be_a(Pathname))
      end

      it 'compare file contents' do
        original_file = Rails.root.join('storage/example.txt')
        created_file = Rails.root.join(arquive.file)

        expect(FileUtils.compare_file(original_file, created_file)).to(be(true))
      end
    end

    context 'with persistence to cloud' do
      let(:arquive) { build(:arquive, persistence: :cloud) }

      before(:each) do
        arquive.save
      end

      it 'correct save file' do
        expect(arquive).to(be_persisted)
      end

      it 'correct save a path' do
        expect(arquive.path).to(be_present)
      end

      it 'return correct file' do
        expect(arquive.file).to(be_present)
        expect(arquive.file).to(be_a(Pathname))
      end
    end
  end
end
