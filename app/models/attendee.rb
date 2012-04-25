class Attendee < ActiveRecord::Base
  include Followings

  has_many :authentications

  is_gravtastic! filetype: :jpg, size: 80

  def conferences
    #Conference.find_all_by_id(rdb[:conference_ids]) # gotcha, didn't call smembers
    Conference.find_all_by_id(rdb[:conference_ids].smembers)
  end

  def events(other=nil)
    if other
      # make a UNION of all events that are shared between you and the conference
      rdb.redis.zinterstore(rdb[:events][other], [rdb[:events], other.rdb[:events]], aggregate: "min")
      Event.where(id: rdb[:events][other].zrange(0, Time.now.to_i))
    else
      Event.where(id: rdb[:events].zrange(0, Time.now.to_i))
    end
  end

  def name
    # won't work with mass-assignment
    rdb[:name].get
  end

  def name=(n)
    # won't work with mass-assignment
    rdb[:name].set n
  end

  def registered?(conference)
    rdb[:conference_ids].sismember conference.id
  end

  def register_for(conference)
    rdb[:conference_ids].sadd conference.id
    conference.register(self)
  end

  def unregister_from(conference)
    rdb[:conference_ids].srem conference.id
    conference.unregister(self)
  end

  def self.null
    Attendee.new
  end
end
