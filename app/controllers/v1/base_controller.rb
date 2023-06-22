# frozen_string_literal: true

class V1::BaseController < ApplicationController
  before_action :record, only: %i[show update destroy]

  def index
    records = if include_relations.blank?
                model.all
              else
                model.includes(include_relations).all
              end

    render json: records
  end

  def show
    render json: @record
  end

  def create
    @record = model.new(record_params)
    if @record.save
      render json: @record, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
  end

  private

  def model
    controller_name.classify.constantize
  end

  def record
    @record = model.find(params[:id])
  end

  def include_relations; end
end
