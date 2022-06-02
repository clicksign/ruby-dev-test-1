# frozen_string_literal: true

module FoldersHelper
  def link_up_folder(folder)
    url = folder&.parent_id.presence ? folder_path(folder.parent_id) : folders_path

    link_to '..', url, class: 'file-item-name'
  end

  def breadcrumb_items(folder = nil) # rubocop:disable Metrics/AbcSize
    return unless folder

    items = []

    if folder&.parent.present?
      items << content_tag(:li, '..', class: 'breadcrumb-item') if folder.parent.parent_id

      link = link_to(folder.parent_name, folder_path(folder.parent_id), class: 'file-item-name')
      items << content_tag(:li, link, class: 'breadcrumb-item')
    end

    items << content_tag(:li, folder.name, class: 'breadcrumb-item active')
    items.join.html_safe # rubocop:disable Rails/OutputSafety
  end
end
