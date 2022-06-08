class DirectorySaving
  class NotSavedDirectoryError < StandardError; end

  attr_reader :errors

  def initialize(params)
    @parent_name = params[:parent]
    @name = params[:name]
    @errors = {}
    @directory = Directory.new
  end
  
  def call
    Directory.transaction do
      build_directory
    ensure
      save!
    end
  end
  
  private
  
  def build_directory
    @directory.name = @name
    @parent = find_parent
  end
  
  def find_parent
    parent = Directory.where(name: @parent_name).last
    parent.nil? ? Directory.create(name: @parent_name) : parent
  end
  
  def save!
    save_record!(@directory)
    parent = @parent.child_binds.build(child_id: @directory.id)
    save_record!(parent)
    raise NotSavedDirectoryError if @errors.present?
  rescue => e
    raise NotSavedDirectoryError
  end

  def save_record!(record)
    record.save!
  rescue ActiveRecord::RecordInvalid
    @errors.merge!(record.errors.messages)
  end
end