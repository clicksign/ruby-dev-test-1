require 'rails_helper'

RSpec.describe Directory, type: :model do
  let(:directory) { create(:directory) }

  it 'must be valid' do
    expect(directory).to be_valid
  end

  %i(name path size).each do |field|
    it { should validate_presence_of(field) }
  end
end