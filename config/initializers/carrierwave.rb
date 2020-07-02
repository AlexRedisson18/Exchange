CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['S3_BUCKET_ID'],
    aws_secret_access_key: ENV['S3_BUCKET_ACCESS_KEY'],
    region:                'eu-west-1'
  }
  config.fog_directory  = 'shit-exchange-bucket'
end
