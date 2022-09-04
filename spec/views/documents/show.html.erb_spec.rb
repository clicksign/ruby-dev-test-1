require 'rails_helper'

RSpec.describe 'documents/show', type: :view do
  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }

  before(:each) do
    @document = assign(:document, Document.create!(title: 'MyText', description: 'MyText', file: file))
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
