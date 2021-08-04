# Load the Rails application.
require_relative "application"

ancestry_pgfix = File.join(Rails.root, 'config', 'ancestry_pgfix.rb')
load(ancestry_pgfix) if File.exist?(ancestry_pgfix)

# Initialize the Rails application.
Rails.application.initialize!
