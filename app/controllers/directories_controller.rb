# frozen_string_literal: true

class DirectoriesController < ApplicationController
  include Errors::Handlers::Http

  def index
    render(json: Directory.first.self_and_descendents, status: :ok)
  end

  def create
    directory = Directory.create!(
      name: create_params[:name],
      parent_id: create_params[:parent_id]
    )

    render(json: directory, status: :created)
  end

  private

  def create_params
    params.permit(:name, :parent_id)
  end
end
