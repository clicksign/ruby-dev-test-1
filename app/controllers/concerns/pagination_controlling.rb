module PaginationControlling
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend
  end

  private

  def paginate(data)
    pagy, records = pagy(data)
    pagy_headers_merge(pagy)

    records
  end
end
