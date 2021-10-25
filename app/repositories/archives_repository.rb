class ArchivesRepository < Repository
  include Mixins::ActiveRecordRepository

  self.target_model = Archive

  class << self
    def find_or_create(archive_params)
      archive = target_model.new(archive_params)
      archive.tap(&:save)
    end
  end
end
