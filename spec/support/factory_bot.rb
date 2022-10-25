RSpec.configure do |config|
  # FactoryBot config
  config.include FactoryBot::Syntax::Methods

  # Lint Factory bot
  # Show raise about factory broke
  config.before(:suite) do
    FactoryBot.lint
  end
end
