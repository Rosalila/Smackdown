OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  file = File.open("facebook.secretkey", "rb")
  provider :facebook, '672588699490076', file.read.chomp
end
