module Pageable
  extend ActiveSupport::Concern

  module ClassMethods
    cattr_accessor :page_size

    def paginate(page, options = {}, per_page = 20)
      
      data = { 
        objects: [],
        pagination: { 
          current_page: page, 
          total_objects: count, 
          per_page: per_page, 
          total_pages: total_pages(per_page, page) 
        } 
      }

      per_page = per_page.blank? ? 20 : per_page
      page = page.blank? ? 0 : (per_page * (page.to_i - 1))
      data[:objects] = offset(page).limit(per_page).as_json(options)

      data
    end

    def total_pages(per_page, page)
      page == 'all' ? 1 : (count.to_f / per_page.to_f).ceil
    end
  end
end
