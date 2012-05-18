# Credit: http://jimneath.org/2011/03/24/using-redis-with-ruby-on-rails.html

module Followings
  # follow another
  def follow!(other)
    rdb.redis.multi do
      rdb[:following].sadd(other.id)
      rdb.redis.sadd(other.rdb[:followers], self.id)
      # need to follow different kinds of objects?
      # rdb[:following][other.class.name].sadd(other.id)
      # rdb.redis.sadd(other.rdb[:followers][self.class.name], self.id)
    end
    # AttendeeFollowedEvent.create(follower: self, following: other,
    #  description: "#{self.name} followed #{other.name}")
  end

  # unfollow another
  def unfollow!(other)
    rdb.redis.multi do
      rdb[:following].srem(other.id)
      rdb.redis.srem(other.rdb[:followers], self.id)
    end
    # AttendeeUnfollowedEvent.create(follower: self, following: other,
    #  description: "#{self.name} unfollowed #{other.name}")    
  end

  # others that self follows
  def followers
    Attendee.where(id: rdb[:followers].smembers)
  end

  # others that follow self
  def following
    Attendee.where(id: rdb[:following].smembers)
  end

  # does the other follow self
  def followed_by?(other)
    rdb[:followers].sismember(other.id)
  end

  # does self follow other
  def following?(other)
    rdb[:following].sismember(other.id)
  end

  # number of followers
  def followers_count
    rdb[:followers].scard
  end

  # number of others being followed
  def following_count
    rdb[:following].scard
  end

  # others who follow and are being followed by self
  def friends
    friends_ids = rdb.redis.sinter(rdb[:following], rdb[:followers])
    Attendee.where(id: friends_ids)
  end

  def friend_of?(other)
    following?(other) && followed_by?(other)
  end
  
  def following_events
    others = following.map {|other| other.rdb[:events] }
    rdb.redis.zunionstore(rdb[:events][:following], [rdb[:events]] + others, aggregate: "min")
    Event.where(id: rdb[:events][:following].zrange(0, -1))
  end
end
