module APIRequest
  def response_body_json
    JSON.parse(response.body)
  rescue StandardError
    {}
  end

  def headers_request
    {
      'Content-Type' => 'application/json', 'Accept' => 'application/json'
    }
  end

  def blob_file(filename)
    ActiveStorage::Blob.create_after_upload!(
      io: File.open(Rails.root.join(file_fixture(filename)), 'rb'),
      filename: filename,
      content_type: 'image/png'
    )
  end
end

RSpec.configure do |config|
  config.include APIRequest, type: :request
end
