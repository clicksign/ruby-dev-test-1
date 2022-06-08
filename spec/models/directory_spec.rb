require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { is_expected.to validate_presence_of(:name) } 
  it { is_expected.to have_many(:archives) }
  it { is_expected.to have_many(:children) }
  it { is_expected.to have_one(:parent) }
end
