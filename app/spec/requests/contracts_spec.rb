require 'rails_helper'

RSpec.describe 'Contracts' do
  it 'should create' do
    # ARRANGE
    user = create(:user)
    # ACT
    post user_contracts_path(
      user_id: user.id
    ), params: {
      format: 'json',
      contract: {
        description: Faker::Lorem.sentence(word_count: 20),
        file: fixture_file_upload('dummy.pdf')
      }
    }
    json = JSON.parse(response.body, symbolize_names: true)
    # ASSERT
    expect(response).to have_http_status(:created)
  end

  it 'should not create' do
    # ARRANGE
    user = create(:user)
    # ACT
    post user_contracts_path(
      user_id: user.id
    ), params: {
      format: 'json',
      contract: {
        file: nil
      }
    }
    json = JSON.parse(response.body, symbolize_names: true)
    # ASSERT
    expect(response).to have_http_status(:internal_server_error)
  end

  it 'should show' do
    # ARRANGE
    contract = create(:contract)
    # ACT
    get user_contract_path(
      user_id: contract.user.id,
      id: contract.id
    ), params: { format: 'json' }
    json = JSON.parse(response.body, symbolize_names: true)
    # ASSERT
    expect(response).to have_http_status(:success)
    expect(json.dig(:contract, :file)).to eq(contract.file.url)
    expect(json.dig(:contract, :id)).to eq(contract.id)
    expect(json.dig(:contract, :description)).to eq(contract.description)
  end

  it 'should return  index' do
    # ARRANGE
    user = create(:user)
    contracts = create_list(:contract, 5, user_id: user.id)
    # ACT
    get user_contracts_path(
      user_id: user.id
    ), params: {
      format: 'json'
    }
    json = JSON.parse(response.body, symbolize_names: true)
    # ASSERT
    expect(response).to have_http_status(:success)
  end
end