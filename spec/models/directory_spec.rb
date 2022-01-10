require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:parent).optional(true) }
  it { is_expected.to have_many(:subdirectories).dependent(:destroy) }

  it 'should have many files' do
    expect(subject.files).to be_an_instance_of(
                                  ActiveStorage::Attached::Many)
  end
end
