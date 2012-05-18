# class FacebookAuthentication < Authentication
#   include RedisProps
  
#   redis_props :info do
#     define :nickname
#     define :email
#     define :image_url
#     define :birthday
#     define :religion
#     define :political
#     define :credentials_token
#     define :urls_facebook
#   end
#   def self.add(user, omniauth)
#     user ||= User.for_email_address(omniauth.info.email)
#     create(provider: omniauth.provider, uid: omniauth.uid, user_id: user.id).tap do |auth|
#       auth.info_nickname = omniauth.info.nickname
#       auth.info_email = omniauth.info.email
#       auth.info_image_url = omniauth.info.image
#       auth.info_birthday = omniauth.extra.raw_info.birthday
#       auth.info_religion = omniauth.extra.raw_info.religion
#       auth.info_political = omniauth.extra.raw_info.political
#       auth.info_credentials_token = omniauth.credentials.token
#       auth.info_urls_facebook = omniauth.info.urls.Facebook
#     end
#   end
# end
