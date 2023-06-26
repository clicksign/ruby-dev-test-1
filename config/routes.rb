Rails.application.routes.draw do
# API Docs
# ---
mount Rswag::Ui::Engine => '/api-docs'
mount Rswag::Api::Engine => '/api-docs'

# Health Check
# ---
get "/ping", to: "ping#show"

# API V1
# ---
draw :api_v1
end
