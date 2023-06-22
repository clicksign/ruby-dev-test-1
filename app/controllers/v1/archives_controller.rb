# frozen_string_literal: true

class V1::ArchivesController < V1::BaseController
  def create
    @record = model.new(record_params)
    attach_file

    if @record.save
      render json: @record, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  private

  def attach_file
    file = params.require(:archive).permit(:file)[:file]

    return unless file

    @tmp_file = Tempfile.new(@record.name)
    @tmp_file.binmode
    @tmp_file.write Base64.decode64(file)
    @tmp_file.rewind

    @record.file.attach(io: @tmp_file, filename: @record.path)
    @tmp_file.unlink
  end

  def record_params
    params.require(:archive).permit(:name, :user_id, :folder_id)
  end

  def include_relations
    %i[folder]
  end
end
