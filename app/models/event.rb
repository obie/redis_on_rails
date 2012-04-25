class Event < ActiveRecord::Base
  after_create :push_to_feeds, :save_details
  # after_destroy not really needed if you always lookup where in (ids)
  default_scope lambda { order('created_at desc').limit(50) }

  protected

  def details
    @details ||= rdb.hgetall
  end

  def save_details
    # rdb.hmset(attributes needed by this event...)
  end

  def push_to_feeds
    rdb.redis.zadd("events", created_at.to_i, self.id)
  end
end
