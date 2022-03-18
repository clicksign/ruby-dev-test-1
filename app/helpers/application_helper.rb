module ApplicationHelper
  def format_datetime(datetime)
    return unless datetime.present?

    I18n.l(datetime, format: '%d/%m/%Y %H:%M:%S')
  end
end
