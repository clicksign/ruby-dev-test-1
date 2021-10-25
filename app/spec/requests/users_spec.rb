require 'rails_helper'

RSpec.describe 'Users' do
  it 'should list' do
    # ARRANGE
    users = create_list(:user, 6)
    # ACT
    get users_path, params: { format: 'json' }
    json = JSON.parse(response.body, symbolize_names: true)
    # ASSERT
    expect(response).to have_http_status(:success)
    expect(json[:users].length).to eq(6)
  end
end