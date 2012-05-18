class FollowEvent < Event
  attr_accessor :follower, :following

  def enhanced_description
    yield description, [follower, following]
  end

  def follower
    @follower ||= Attendee.find_by_id(details["follower_id"])
  end

  def following
    @following ||= Attendee.find_by_id(details["following_id"])
  end

  protected

  def save_details
    super(follower_id: follower.id, following_id: following.id)
  end

  def push_to_feeds
    follower.rdb["events"].zadd(created_at.to_i, self.id)
    following.rdb["events"].zadd(created_at.to_i, self.id)
  end
end
