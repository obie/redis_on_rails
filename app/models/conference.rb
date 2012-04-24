class Conference < ActiveRecord::Base
  include Redis::Objects

  value :location

  attr_accessor :location

  def attendees
    # Attendee.find(rdb[:attendee_ids])
    Attendee.find_all_by_id(rdb[:attendee_ids].smembers)
    # gotcha note.. consumers might try to << attendees
  end

  def location
    rdb[:location].get
  end

  def location=(loc)
    rdb[:location].set loc
  end

  def register(attendee)
    rdb[:attendee_ids].sadd(attendee.id)
  end

  def registered?(attendee)
    rdb[:attendee_ids].sismember(attendee.id)
  end

  def unregister(attendee)
    rdb[:attendee_ids].srem(attendee.id)
  end
  
  def notes_for(attendee)
    rdb[:notes].hget(attendee.id)
  end
  
  def set_notes_for(attendee, text)
    rdb[:notes].hset(attendee.id, text)
  end
end
