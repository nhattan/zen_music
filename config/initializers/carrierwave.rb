CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'ap-southeast-1',
    }
    config.fog_directory  = ENV['AWS_BUCKET']
    config.fog_public     = true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day}" }
    # config.cache_dir = "/tmp/uploads" uncommend it to work on Heroku/AWS EC2
    config.asset_host = ENV['AWS_CLOUDFRONT_URL']
  end
end
