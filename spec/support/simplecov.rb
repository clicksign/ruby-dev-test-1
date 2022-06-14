require 'simplecov'

SimpleCov.start 'rails' do
  add_filter %w[bin db config spec test app/channels app/helpers app/mailers]
end