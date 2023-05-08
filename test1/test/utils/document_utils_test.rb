require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  test 'fail to save document (by utils) without folder' do
    document_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: document_name, storage: 'blob')
    assert_not(uploaded, 'The document should not be uploaded without folder')
  end

  test 'fail to save document (by utils) with invalid name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/*(=+)", storage: 'blob')
    assert_not(uploaded, 'The document should not be uploaded with invalid name')
  end

  test 'successfully save document (by utils) with formatted name' do
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/(a*b=+)c\ -|d,e.f_1;2:3", storage: 'blob')
    assert(uploaded, 'The document should be uploaded with success')
    downloaded = DocumentUtils.download("#{folder_name}/abc-def_123")
    assert_not_nil(downloaded, 'The document should be downloaded with formatted name')
  end

  test 'fail to save document (by utils) without storage method' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}")
    assert_not(uploaded, 'The document should not be uploaded without storage method')
  end

  test 'fail to save document (by utils) with blank storage method' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}", storage: '')
    assert_not(uploaded, 'The document should not be uploaded with blank storage method')
  end

  test 'fail to save document (by utils) with nil content' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = nil
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}", storage: 'blob')
    assert_not(uploaded, 'The document should not be uploaded with nil content')
  end

  test 'save document (by utils) of 1 megabyte stored in database on blob format and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}", storage: 'blob')
    assert(uploaded, 'Document should be uploaded')

    downloaded = DocumentUtils.download("#{folder_name}/#{document_name}")
    assert_equal(1.megabyte, File.size(downloaded), 'The file size returned should have 1 megabyte')

    destroyed = DocumentUtils.destroy("#{folder_name}/#{document_name}")
    assert(destroyed, 'The document should be deleted')
  end

  test 'save document (by utils) of 1 megabyte stored in disk and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}", storage: 'disk')
    assert(uploaded, 'Document should be uploaded')

    downloaded = DocumentUtils.download("#{folder_name}/#{document_name}")
    assert_equal(1.megabyte, File.size(downloaded), 'The file size returned should have 1 megabyte')

    destroyed = DocumentUtils.destroy("#{folder_name}/#{document_name}")
    assert(destroyed, 'The document should be deleted')
  end

  test 'save document (by utils) of 1 megabyte stored in s3 and deleted after' do
    document_name = SecureRandom.uuid
    folder_name = SecureRandom.uuid

    file_content = fixture_file_upload('1.megabyte', nil, :binary)
    uploaded = DocumentUtils.upload(file_content, full_path: "#{folder_name}/#{document_name}", storage: 's3')
    assert(uploaded, 'Document should be uploaded')

    downloaded = DocumentUtils.download("#{folder_name}/#{document_name}")
    assert_equal(1.megabyte, File.size(downloaded), 'The file size returned should have 1 megabyte')

    destroyed = DocumentUtils.destroy("#{folder_name}/#{document_name}")
    assert(destroyed, 'The document should be deleted')
  end
end
