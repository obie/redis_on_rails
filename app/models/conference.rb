class Conference < ActiveRecord::Base
  #include Redis::Objects
  #value :location

  default_scope lambda { order('name asc') }

  has_many :talks
  has_many :tutorials

  # gotcha note.. consumers might try to << attendees
  def attendees
    # Attendee.find(rdb[:attendee_ids])
    Attendee.find_all_by_id(rdb[:attendee_ids].smembers)
  end

  def self.events
    Event.where(id: rdb[:events].zrange(0, -1))
  end

  def location
    rdb[:location].get
  end
  
  def location=(loc)
    rdb[:location].set loc
  end

  def register(attendee)  
    Redis.current.multi do
      rdb[:attendee_ids].sadd(attendee.id)
      attendee.rdb[:conference_ids].sadd id
    end
    # AttendeeRegisteredEvent.create(attendee: attendee,
    #   conference: self, description: "#{attendee.name} registered for #{name}")
  end

  def registered?(attendee)
    rdb[:attendee_ids].sismember(attendee.id)
  end

  def unregister(attendee)
    Redis.current.multi do
      rdb[:attendee_ids].srem(attendee.id)
      attendee.rdb[:conference_ids].srem id
    end
    # AttendeeUnregisteredEvent.create(attendee: attendee,
    #   conference: self, description: "#{attendee.name} unregistered from #{name}")
  end

  def notes_for(attendee)
    rdb[:notes].hget(attendee.id)
  end
  
  def set_notes_for(attendee, text)
    rdb[:notes].hset(attendee.id, text)
    # AttendeeNotesUpdatedEvent.create(attendee: attendee,
    #  conference: self, description: "#{attendee.name} updated his notes for #{name}")
  end

  def to_s
    name
  end

  # protected
  # 
  # def after_create
  #   ConferenceCreatedEvent.create(conference: self, description: "#{name} was added to the site")
  # end
end
