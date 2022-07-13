Dir["services/*.rb"].each { |file| require file }

class ApplicationController < ActionController::API
  private

  def parse_boolean(value)
    ActiveRecord::Type::Boolean.new.deserialize(value)
  end
end
