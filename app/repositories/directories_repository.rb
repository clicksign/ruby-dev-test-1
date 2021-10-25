class DirectoriesRepository < Repository
  include Mixins::ActiveRecordRepository

  self.target_model = Directory

  class << self
    def find_or_create(path)
      archive = target_model.find_or_initialize_by(path: path)
      archive.tap(&:save)
    end
  end
end
