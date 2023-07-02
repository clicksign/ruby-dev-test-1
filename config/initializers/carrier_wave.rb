CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAJ43GCWKPFKFZALXA',
    aws_secret_access_key: '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',
    region:                'us-west-2',
  }
  # config.storage :fog
  config.fog_directory  = 'clicksign_devtest1'
end

module CarrierWave
  module RMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
