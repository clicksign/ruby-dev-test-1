module Documents
  class LocalDocument < Document
    has_one_attached :file, service: :local
  end
end
