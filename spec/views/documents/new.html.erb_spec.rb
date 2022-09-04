require 'rails_helper'

RSpec.describe 'documents/new', type: :view do
  it 'check form behavior' do
    visit(new_document_path)
    expect(page).to have_current_path(new_document_path)
    fill_in('document[title]', with: 'document.title')
    fill_in('document[description]', with: 'document.description')  
    attach_file('document[file]', "#{Rails.root}/spec/factories/files/file_mock.txt")
    click_on('commit')
    expect(page).to have_current_path(document_path(Document.last.id))
    expect(page).to have_content('Document was successfully created.')
  end
end
