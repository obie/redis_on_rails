class Event < ActiveRecord::Base
  attr_accessor :attendee, :conference
  after_create :push_to_feeds, :save_details
  default_scope lambda { order('created_at desc').limit(50) }
  
  def attendee
    @attendee ||= Attendee.find_by_id(details["attendee_id"])
  end
  
  def conference
    # no hash with indifferent access
    #@conference ||= Conference.find_by_id(details[:conference_id])
    @conference ||= Conference.find_by_id(details["conference_id"])
  end
  
  protected
  
  def details
    @details ||= rdb.hgetall
  end
  
  def save_details
    rdb.hmset(:attendee_id, attendee.id, :conference_id, conference.id)
  end
  
  def push_to_feeds
    rdb.redis.zadd("events", created_at.to_i, self.id)
    attendee.rdb["events"].zadd(created_at.to_i, self.id)
    conference.rdb["events"].zadd(created_at.to_i, self.id)
  end
end