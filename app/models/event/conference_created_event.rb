class ConferenceCreatedEvent < Event
  attr_accessor :conference
  
  def conference
    @conference ||= Conference.find_by_id(details["conference_id"])
  end
  
  def enhanced_description
    yield description, [conference]
  end

  protected

  def save_details
    super(conference_id: conference.id)
  end

  def push_to_feeds
    super
    Conference.rdb["events"].zadd(created_at.to_i, self.id)
    conference.rdb["events"].zadd(created_at.to_i, self.id)
  end
end
