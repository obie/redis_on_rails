class AttendeeConferenceEvent < Event
  attr_accessor :attendee, :conference

  def attendee
    @attendee ||= Attendee.find_by_id(details["attendee_id"])
  end

  def conference
    # no hash with indifferent access
    #@conference ||= Conference.where(id: details[:conference_id])
    @conference ||= Conference.find_by_id(details["conference_id"])
  end
  
  def enhanced_description
    yield description, [attendee, conference]
  end

  protected

  def save_details
    super(attendee_id: attendee.id, conference_id: conference.id)
  end

  def push_to_feeds
    super
    attendee.rdb["events"].zadd(created_at.to_i, self.id)
    conference.rdb["events"].zadd(created_at.to_i, self.id)
  end
end
