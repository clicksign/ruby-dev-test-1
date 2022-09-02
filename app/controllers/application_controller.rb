class ApplicationController < ActionController::API
    before_action :ensure_json_request

    def ensure_json_request
        return if request.headers['Accept'] =~ /vnd\.api\+json/
        render body: nil, status: :not_acceptable
    end
end
