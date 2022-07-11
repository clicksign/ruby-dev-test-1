Dir["services/*.rb"].each { |file| require file }

class ApplicationController < ActionController::API
end
