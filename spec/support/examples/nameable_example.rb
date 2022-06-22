RSpec.shared_examples 'nameable' do
  describe 'validations' do
    subject { create(:directory) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(250) }
    it do
      is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id)
    end

    describe "name cannot start with '/' or ' '" do
      let(:directory) { build(:directory, name: name) }

      context 'when name is valid' do
        let(:name) { 'some valid name' }

        it { expect(directory).to be_valid }
      end

      context "when name starts with '/'" do
        let(:name) { '/invalid name' }

        it { expect(directory).not_to be_valid }
      end

      context "when name starts with ' '" do
        let(:name) { ' invalid name' }

        it { expect(directory).not_to be_valid }
      end
    end
  end
end