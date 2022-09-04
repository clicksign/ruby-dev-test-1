require 'rails_helper'

RSpec.describe 'documents/edit', type: :view do
  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }

  before(:each) do
    @document = assign(:document, Document.create!(title: 'MyText', description: 'MyText', file: file))
  end

  it 'renders the edit document form' do
    render

    assert_select 'form[action=?][method=?]', document_path(@document), 'post' do
      assert_select 'input[name=?]', 'document[title]'

      assert_select 'textarea[name=?]', 'document[description]'
    end
  end
end
