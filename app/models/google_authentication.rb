class GoogleAuthentication < Authentication
  def self.add(attendee, omniauth)
    attendee ||= Attendee.find_or_create_by_email(omniauth.info.email).tap do |a|
      a.name = omniauth.info.name
    end
    create(provider: omniauth["provider"], uid: omniauth["uid"], attendee_id: attendee.id)
  end
end
