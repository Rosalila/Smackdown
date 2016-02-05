OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.production?
    file = File.open("/home/rails/facebook.secretkey", "rb")
  else
    file = File.open("/home/turupawn/facebook.secretkey", "rb")
  end
  provider :facebook, '672588699490076', file.read.chomp
  provider :steam, '63B42B959BC86C52FCA00AD37AFCC81C'
end
