require 'rails_helper'

RSpec.feature 'Feature Folders', type: :feature do
  let(:user) { create(:user) }

  describe '#index' do
    before :each do
      visit(new_user_session_path)
      fill_in('user[email]', with: user.email)
      fill_in('user[password]', with: '123456')
      click_on('commit')
      visit(folders_path)
    end

    it 'check index content' do
      expect(page).to have_current_path(folders_path)

      find_link(class: ['breadcrumb-link']).visible?
      find_button('Upload File').visible?
      find_button('New Folder').visible?
    end

    describe 'check form behavior on create' do
      it 'new document' do
        expect(page).to have_current_path(folders_path)

        click_on('Upload File')
        fill_in('document[title]', with: 'Example 1')
        attach_file('document[file]', "#{Rails.root}/spec/factories/files/file_mock.txt")
        click_on('btn-submit')

        expect(page.html).to match(/Document was successfully created./)
      end

      it 'new folder' do
        expect(page).to have_current_path(folders_path)

        click_on('New Folder')
        fill_in('folder[name]', with: 'Example 1')
        click_on('btn-folder-submit')

        expect(page.html).to match(/Folder was successfully created./)
      end
    end

    describe 'check form behavior on update' do
      before do
        click_on('Upload File')
        fill_in('document[title]', with: 'Example 1')
        attach_file('document[file]', "#{Rails.root}/spec/factories/files/file_mock.txt")
        click_on('btn-submit')
        @document_id = Document.last.id

        click_on('New Folder')
        fill_in('folder[name]', with: 'Example 1')
        click_on('btn-folder-submit')
        @folder_id = Folder.last.id

        @root = Folder.where(name: 'Root').first
      end

      it 'update document' do
        expect(page).to have_current_path(folder_path(@root))
        fill_in("input-doc-title#{@document_id}", with: 'Example 2')
        click_on("btn-submit#{@document_id}")

        expect(page.html).to match(/Document was successfully updated./)
      end

      it 'update folder' do
        expect(page).to have_current_path(folder_path(@root))
        fill_in("input-folder-name#{@folder_id}", with: 'Example 2')
        click_on("btn-folder-submit#{@folder_id}")

        expect(page.html).to match(/Folder was successfully updated./)
      end
    end

    describe 'check form behavior on destroy' do
      before do
        click_on('Upload File')
        fill_in('document[title]', with: 'Example 1')
        attach_file('document[file]', "#{Rails.root}/spec/factories/files/file_mock.txt")
        click_on('btn-submit')
        @document_id = Document.last.id

        click_on('New Folder')
        fill_in('folder[name]', with: 'Example 1')
        click_on('btn-folder-submit')
        @folder_id = Folder.last.id

        @root = Folder.where(name: 'Root').first
      end

      it 'destroy document' do
        expect(page).to have_current_path(folder_path(@root))
        click_on("btn-doc-destroy#{@document_id}")

        expect(page.html).to match(/Document was successfully destroyed./)
      end

      it 'destroy folder' do
        expect(page).to have_current_path(folder_path(@root))
        click_on("btn-folder-destroy#{@folder_id}")

        expect(page.html).to match(/Folder was successfully destroyed./)
      end
    end
  end
end
