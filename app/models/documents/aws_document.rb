module Documents
  class AWSDocument < Document
    has_one_attached :file, service: :amazon
  end
end
