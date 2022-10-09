# frozen_string_literal: true

if Rails.env.production?
  Aws.config.update(
    {
      region: ENV.fetch('AWS_REGION'),
      credentials: Aws::Credentials.new(
        ENV.fetch('AWS_ACCESS_KEY_ID'),
        ENV.fetch('AWS_SECRET_ACCESS_KEY')
      )
    }
  )
else
  Aws.config.update(
    {
      region: ENV.fetch('AWS_REGION'),
      credentials: Aws::Credentials.new(
        ENV.fetch('AWS_ACCESS_KEY_ID'),
        ENV.fetch('AWS_SECRET_ACCESS_KEY')
      ),
      endpoint: ENV.fetch('LOCALSTACK_ENDPOINT_URL'),
      force_path_style: true
    }
  )

  Aws::S3::Resource.new.create_bucket({ bucket: ENV.fetch('AWS_S3_BUCKET') })
end
