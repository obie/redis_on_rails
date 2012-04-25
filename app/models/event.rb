class Event < ActiveRecord::Base
  attr_accessor :attendee, :conference
  after_create :push_to_feeds
  default_scope lambda { order('created_at desc').limit(50) }
  protected
  
  def push_to_feeds
    rdb.redis.zadd("events", created_at.to_i, self.id)
    attendee.rdb["events"].zadd(created_at.to_i, self.id)
    conference.rdb["events"].zadd(created_at.to_i, self.id)
  end
end