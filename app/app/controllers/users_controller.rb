class UsersController < ApplicationController
  def index
    @users = Users::FetchPage.list(
      page: params[:page],
    )
  end
end