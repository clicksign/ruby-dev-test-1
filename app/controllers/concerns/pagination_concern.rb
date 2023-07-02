# Module to manage pagination
module PaginationConcern
  extend ActiveSupport::Concern

  PER_PAGE = 20

  included do
    attr_reader(:current_page, :current_per_page)
  end

  def setup_pagination
    @current_page = params[:page]
    @current_per_page = params[:per_page]
    page
    per_page
  end

  def page
    current_page == 'all' ? current_page : get_page
  end

  def get_page
    @current_page = current_page.to_i
    current_page < 1 ? 1 : current_page
  end

  def per_page
    @current_per_page = current_per_page.blank? ? PER_PAGE : current_per_page.to_i
  end
end
