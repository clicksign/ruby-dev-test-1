require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:document) { create(:document) }

  it 'must be valid' do
    expect(document).to be_valid
  end

  %i(name ext size path).each do |field|
    it { should validate_presence_of(field) }
  end
end