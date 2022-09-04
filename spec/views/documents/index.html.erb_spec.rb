require 'rails_helper'

RSpec.describe 'documents/index', type: :view do
  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }

  before(:each) do
    assign(:documents, [create(:document, title: 'MyText'), create(:document, title: 'MyText')])
  end

  it 'renders a list of documents' do
    render
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
