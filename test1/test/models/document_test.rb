require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  test 'fail to save document without folder' do
    document_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, storage_method: StorageMethods::Blob)
    assert_not(document.upload(file_content), 'The document should not be uploaded without folder')
  end

  test 'fail to save document without name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded without name')
  end

  test 'fail to save document with blank name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: '', storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded with blank name')
  end

  test 'fail to save document with invalid name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: '*(=+)', storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded with invalid name')
  end

  test 'successfully save document with formatted name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: '(a*b=+)c\ -/|d,e.f_1;2:3', storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert(document.upload(file_content), 'The document should be uploaded with success')
    assert_equal('abc-def_123', document.name, 'The document should be uploaded with formatted name')
  end

  test 'fail to save document without storage method' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded without storage method')
  end

  test 'fail to save document with blank storage method' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, storage_method: '', folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded with blank storage method')
  end

  test 'fail to save document with nil content' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = nil
    document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert_not(document.upload(file_content), 'The document should not be uploaded with nil content')
  end

  test 'save document of 1 megabyte stored in database on blob format and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert(document.upload(file_content), 'Document should be uploaded')
    assert(document.persisted?, 'Document should be persisted')

    uploaded_document = Document.find(document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    key = uploaded_document.key
    stored_file = StorageMethods::Blob.new.download(key)
    assert_equal(1.megabyte, File.size(stored_file), 'The file size returned should have 1 megabyte')
    assert(uploaded_document.destroy, 'The document should be deleted')
    deleted_file = StorageMethods::Blob.new.download(key)
    assert_nil(deleted_file, 'The file should not exist anymore and must be returned nil')
  end

  test 'save document of 1 megabyte stored in disk and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, storage_method: StorageMethods::Disk, folder: Folder.path!(folder_name))
    assert(document.upload(file_content), 'Document should be uploaded')
    assert(document.persisted?, 'Document should be persisted')

    uploaded_document = Document.find(document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    key = uploaded_document.key
    stored_file = StorageMethods::Disk.new.download(key)
    assert_equal(1.megabyte, File.size(stored_file), 'The file size returned should have 1 megabyte')
    assert(uploaded_document.destroy, 'The document should be deleted')
    deleted_file = StorageMethods::Disk.new.download(key)
    assert_nil(deleted_file, 'The file should not exist anymore and must be returned nil')
  end

  test 'save document of 1 megabyte stored in s3 and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    document = Document.new(name: document_name, storage_method: StorageMethods::S3, folder: Folder.path!(folder_name))
    assert(document.upload(file_content), 'Document should be uploaded')
    assert(document.persisted?, 'Document should be persisted')

    uploaded_document = Document.find(document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    key = uploaded_document.key
    stored_file = StorageMethods::S3.new.download(key)
    assert_equal(1.megabyte, File.size(stored_file), 'The file size returned should have 1 megabyte')
    assert(uploaded_document.destroy, 'The document should be deleted')
    deleted_file = StorageMethods::S3.new.download(key)
    assert_nil(deleted_file, 'The file should not exist anymore and must be returned nil')
  end

  test 'successfully save first document and fail to save the second document with equal folder and name' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    first_file_content = fixture_file_upload('1.megabyte', nil, :binary)
    first_document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert(first_document.upload(first_file_content), 'The first document should be uploaded')
    assert(first_document.persisted?, 'The first document should be persisted')

    uploaded_document = Document.find(first_document.id)
    assert_equal(1.megabyte, File.size(uploaded_document.download), 'The file size returned should have 1 megabyte')

    second_file_content = fixture_file_upload('512.kilobytes', nil, :binary)
    second_document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert_not(second_document.upload(second_file_content), 'The second document should not be saved')
    
    second_document_file = StorageMethods::Blob.new.download(second_document.key)
    assert_nil(second_document_file, 'The file should not exist and must be returned nil')
  end

  test 'successfully save two documents with equal name and different folders' do
    document_name = SecureRandom.uuid
    first_folder_name = "#{SecureRandom.uuid}/folder"
    second_folder_name = "folder/#{SecureRandom.uuid}"

    first_file_content = fixture_file_upload('1.megabyte', nil, :binary)
    first_document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(first_folder_name))
    assert(first_document.upload(first_file_content), 'The first document should be uploaded')
    assert(first_document.persisted?, 'The first document should be persisted')
    assert_equal("#{first_folder_name}/#{document_name}", first_document.path, 'The file path is wrong')

    uploaded_first_document = Document.find(first_document.id)
    assert_equal(1.megabyte, File.size(uploaded_first_document.download), 'The file size returned should have 1 megabyte')

    second_file_content = fixture_file_upload('512.kilobytes', nil, :binary)
    second_document = Document.new(name: document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(second_folder_name))
    assert(second_document.upload(second_file_content), 'The second document should be uploaded')
    assert(second_document.persisted?, 'The second document should be persisted')
    assert_equal("#{second_folder_name}/#{document_name}", second_document.path, 'The file path is wrong')

    uploaded_second_document = Document.find(second_document.id)
    assert_equal(512.kilobytes, File.size(uploaded_second_document.download), 'The file size returned should have 512 kilobytes')

    assert_equal(1, Folder.path(first_folder_name).documents.count, 'The counting of documents in first folder should be one')
    assert_equal(1, Folder.path(second_folder_name).documents.count, 'The counting of documents in second folder should be one')

    assert(uploaded_first_document.destroy, 'The first document should be deleted')
    assert(uploaded_second_document.destroy, 'The second document should be deleted')
  end

  test 'successfully save two documents with different names and equal folder' do
    first_document_name = SecureRandom.uuid
    second_document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    first_file_content = fixture_file_upload('1.megabyte', nil, :binary)
    first_document = Document.new(name: first_document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert(first_document.upload(first_file_content), 'The first document should be uploaded')
    assert(first_document.persisted?, 'The first document should be persisted')

    uploaded_first_document = Document.find(first_document.id)
    assert_equal(1.megabyte, File.size(uploaded_first_document.download), 'The file size returned should have 1 megabyte')

    second_file_content = fixture_file_upload('512.kilobytes', nil, :binary)
    second_document = Document.new(name: second_document_name, storage_method: StorageMethods::Blob, folder: Folder.path!(folder_name))
    assert(second_document.upload(second_file_content), 'The second document should be uploaded')
    assert(second_document.persisted?, 'The second document should be persisted')

    uploaded_second_document = Document.find(second_document.id)
    assert_equal(512.kilobytes, File.size(uploaded_second_document.download), 'The file size returned should have 512 kilobytes')

    assert_equal(2, Folder.path(folder_name).documents.count, 'The counting of documents in folder should be two')

    assert(uploaded_first_document.destroy, 'The first document should be deleted')
    assert(uploaded_second_document.destroy, 'The second document should be deleted')
  end
end
