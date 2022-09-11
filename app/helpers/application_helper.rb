module ApplicationHelper
  def list_folders(folder)
    return unless user_signed_in?

    "<ul>
      <li><span class='caret'>#{folder.name}</span>
        <ul class='nested'>".html_safe +
          get_children(folder).html_safe  +
        "</ul>
      </li>
    </ul>".html_safe
  end

  def get_children(parent)
    children = []
    parent.children.each do |child|
      children << "<li><a href='/folders/#{child.id}' >#{child.name}</a></li>"
    end

    children.join
  end

  def list_documents(folder)
    return unless user_signed_in?

    "<ul>
      <li><span class='caret'>#{folder.name}</span>
        <ul class='nested'>".html_safe +
          get_docs(folder).html_safe  +
        "</ul>
      </li>
    </ul>".html_safe
  end

  def get_docs(folder)
    docs = []
    folder.documents.each do |doc|
      docs << "<li><span>#{doc.file.blob.filename}</span></li>"
    end

    docs.join
  end
end
