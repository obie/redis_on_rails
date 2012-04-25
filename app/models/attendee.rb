class Attendee < ActiveRecord::Base
  has_many :authentications

  is_gravtastic! filetype: :jpg, size: 80

  def conferences
    #Conference.find_all_by_id(rdb[:conference_ids]) # gotcha, didn't call smembers
    Conference.find_all_by_id(rdb[:conference_ids].smembers)
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
