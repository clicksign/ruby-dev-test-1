# frozen_string_literal: true

class ArquivesController < ApplicationController
  include Errors::Handlers::Http

  def index
    arquives = Arquive.where(directory_id: params[:directory_id])
    render(json: arquives, status: :ok)
  end

  def create
    arquive = Arquive.create!(
      name: create_params[:name],
      persistence: create_params[:persistence],
      data: create_params[:data],
      directory_id: create_params[:directory_id]
    )

    render(json: arquive, status: :created)
  end

  def file
    arquive = Arquive.find(params[:id])

    send_file(File.open(arquive.file), filename: arquive.name)
  end

  private

  def create_params
    params.permit(:name, :persistence, :data, :directory_id)
  end
end
