class Repository
  class_attribute :target_model

  def execute_query(*args)
    self.class.execute_query(*args)
  end

  class << self
    def execute_query(sql)
      ActiveRecord::Base.connection.execute(sql).to_a.map(&:deep_symbolize_keys)
    end
  end
end
