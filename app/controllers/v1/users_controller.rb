# frozen_string_literal: true

class V1::UsersController < V1::BaseController
  skip_before_action :authenticate, only: %i[create]

  private

  def record_params
    params.require(:user).permit(%i[name password password_confirmation])
  end
end
