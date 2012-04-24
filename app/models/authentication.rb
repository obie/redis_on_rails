class Authentication < ActiveRecord::Base
  belongs_to :attendee

  def self.authenticate(omniauth)
    provider = omniauth['provider']
    find_by_provider_and_uid(provider, omniauth['uid']) || send(provider, nil, omniauth)
  end

  def self.google(user, omniauth)
    GoogleAuthentication.add(user, omniauth)
  end

end
