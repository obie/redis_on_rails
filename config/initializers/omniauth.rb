Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'
   provider :google
end
