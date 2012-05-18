module Taggable
  def tag(space_delimited_tags)
    tags = space_delimited_tags.split
    Redis.current.multi do
      rdb[:tags].sadd(*tags)
      tags.each { |t| rdb.redis.sadd(t, id) }
    end
  end
  
  def tags
    rdb[:tags].smembers.join(" ")
  end
  
  def self.tagged()
    r
  end
end
