module ApplicationHelper

  def render_directories(directories)
    directories = [] if directories.nil?
    directories = [directories] if directories.is_a?(Directory)
    html = []

    directories&.each do |dir|
      html << render_directory(dir)
    end

    safe_join(html, '')
  end

  def render_directory(directory)
    content_tag(
      :ul,
      draw_directory(directory),
      nil
    )
  end

  def draw_directory(directory)
    html = [
      content_tag(
        :li,
        safe_join(html, ''),
        nil
      )
    ]

    return html if directory.childrens.empty?

    html << render_directories(directory.childrens)

    content_tag(
      :li,
      safe_join(html, ''),
      nil
    )
  end
end
