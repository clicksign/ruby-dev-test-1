class ArchiveSaving
  class NotSavedArchiveError < StandardError; end

  attr_reader :errors, :archive

  def initialize(params)
    @name = params[:name]
    @data = params[:data]
    @directory_name = params[:directory]
    @errors = {}
  end
  
  def call
    Archive.transaction do
      build_archive
    ensure
      save!
    end
  end
  
  private
  
  def build_archive
    @directory = find_directory
    @archive = Archive.new(name: @name, directory_id: @directory.id)
    @archive.datas.attach(@data)
  end

  def find_directory
    directory = Directory.where(name: @directory_name).last
    directory.nil? ? Directory.create(name: @directory_name) : directory
  end

  def save!
    save_record!(@archive)
    raise NotSavedArchiveError if @errors.present?
  rescue => e
    raise NotSavedArchiveError
  end

  def save_record!(record)
    record.save!
  rescue ActiveRecord::RecordInvalid
    @errors.merge!(record.errors.messages)
  end
end