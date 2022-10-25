module Files
  class CreateLocalFile
    attr_reader :medium, :local_file

    def initialize(params:, medium: ::Medium, local_file: ::LocalFile)
      @params     = params
      @medium     = medium
      @local_file = local_file
    end

    def save
      ActiveRecord::Base.transaction do
        local_file = @local_file.create!(file_params)

        @medium.create!(
          fileable_id: local_file.id,
          fileable_type: local_file.class.name,
          folder_id:
        )
      end
    end

    private

    def file_params
      @params.except(:folder_id)
    end

    def folder_id
      @params[:folder_id]
    end
  end
end
