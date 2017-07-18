require 'carrierwave/storage/fog'
CarrierWave.configure do |config|
 config.fog_credentials = {
   provider: "AWS",
   aws_access_key_id: ENV['aws_access_key_id'],
   aws_secret_access_key: ENV['aws_secret_access_key'],
   region: ENV['region_primary'],
   region: ENV['region_secondary'],
   path_style: true

}
config.fog_directory = ENV['left_primary_fog'],
config.fog_directory = ENV['right_secondary_fog'],
config.fog_attributes = {'x-amz-server-side-encryption' => 'AES256','Cache-Control'=>'max-age=315576000'}
end