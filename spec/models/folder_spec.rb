require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'validations' do
    specify { is_expected.to validate_presence_of(:label) }
  end
end
