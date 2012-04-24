class Attendee < ActiveRecord::Base
  attr_accessor :name
  has_many :authentications

  is_gravtastic! filetype: :jpg, size: 80

  def attending?(conference)
    rdb[:conference_ids].sismember conference.id
  end

  def name
    rdb[:name].get
  end

  def name=(n)
    rdb[:name].set n
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
