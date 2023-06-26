module SerializeControlling
  extend ActiveSupport::Concern

  private

  def serialize(data, serialize)
    raise "#{serialize} not defined" unless Object.const_defined?(serialize.to_s)

    serialize.new.serialize(data).to_json
  end

  def each_serialize(data, serialize)
    raise "#{serialize} not defined" unless Object.const_defined?(serialize.to_s)

    Panko::ArraySerializer.new(data, { each_serializer: serialize }).to_json
  end
end
