Rails.application.config.generators do |gs|
  gs.orm :active_record, primary_key_type: :uuid
end