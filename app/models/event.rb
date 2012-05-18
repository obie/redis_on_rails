class Event < ActiveRecord::Base
  include Redis::Objects
  sorted_set :events

  default_scope lambda { order('created_at desc').limit(50) }
  after_create :push_to_feeds, :save_details
  # after_destroy not really needed if you always lookup where in (ids)

  protected

  def details
    @details ||= rdb.hgetall
  end

  def save_details(attrs={})
    rdb.hmset(*attrs.to_a.flatten)
  end

  def push_to_feeds
    #rdb.redis.zadd("events", created_at.to_i, self.id)
    events[created_at.to_i] = self.id
  end
end
