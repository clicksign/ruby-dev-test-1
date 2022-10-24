require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'validations' do
    specify { is_expected.to validate_presence_of(:label) }
  end

  describe 'uniqueness index label scoped with ancestry' do
    specify { is_expected.to have_db_column(:ancestry).of_type(:string) }

    context 'if ancestry is null' do
      before { allow(subject).to receive(:ancestry).and_return(nil) }

      specify { is_expected.to have_db_index(:label).unique(true) }
    end

    context 'if ancestry is not null' do
      before { allow(subject).to receive(:ancestry).and_return('1/2') }

      specify { is_expected.to have_db_index(%i[label ancestry]).unique(true) }
    end
  end
end
