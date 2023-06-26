# frozen_string_literal: true

# require lib root files (lib/*.rb)
Dir[Rails.root.join("lib", "*.rb")].sort.each { |f| require_dependency f }
