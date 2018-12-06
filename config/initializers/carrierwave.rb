CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'
  # config.cache_dir = "#{Rails.root}/tmp/uploads"
  # config.permissions = 0666
  # config.fog_directory  = ENV['S3_BUCKET']
  # config.fog_credentials = {
  #   provider: 'AWS',
  #   aws_access_key_id: ENV['S3_ACCESS_KEY'],
  #   aws_secret_access_key: ENV['S3_SECRET_KEY'],
  #   region: ENV['S3_REGION'],
  #   path_style: true
  # }
  # config.asset_host     =   "https://s3.amazonaws.com/#{config.fog_directory}"
  # config.fog_public     =   false
  # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }

  # config.storage = :fog
end
 
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

