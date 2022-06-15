require 'rails_helper'

RSpec.describe Archive, type: :model do
  it { is_expected.to validate_presence_of(:name) } 
  it { is_expected.to have_many_attached(:datas) }
  it { is_expected.to belong_to(:directory) }
end
