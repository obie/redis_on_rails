class GoogleAuthentication < Authentication
  def self.add(user, omniauth)
    user ||= User.find_by_email(omniauth["info"]["email"])
    create(provider: omniauth["provider"], uid: omniauth["uid"], user_id: user.id)
  end
end
