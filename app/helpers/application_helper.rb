module ApplicationHelper
  def show_errors_for(object)
    return unless object.try(:errors).try(:any?)

    content_tag(:div, class: 'block block-rounded block-themed border border-danger') do
      concat(content_tag(:div, class: 'block-header bg-danger') do
        concat(content_tag(:h3, class: 'block-title') do
          if object.errors.count == 1
            concat '1 erro foi encontrado:'
          else
            concat "#{pluralize(object.errors.count, 'erros')} foram encontrados:"
          end
        end)
      end)
      concat(content_tag(:ul, class: 'list-group list-group-flush') do
        object.errors.full_messages.each do |msg|
          concat content_tag(:li, msg, class: 'list-group-item text-danger')
        end
      end)
    end
  end

  def url_directory_parent(directory)
    directory.parent.present? ? directory_path(directory.parent) : directories_path
  end
  
  def name_directory_parent(directory)
    directory.parent.present? ? "#{directory.parent.name} - " : "Inicio - "
  end
end
