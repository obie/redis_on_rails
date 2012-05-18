# Copyright (c) 2010 Michel Martens & Damian Janowski

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "redis"

class Nest < String
  VERSION = "1.1.0"

  METHODS = [:append, :blpop, :brpop, :brpoplpush, :decr, :decrby,
  :del, :exists, :expire, :expireat, :get, :getbit, :getrange, :getset,
  :hdel, :hexists, :hget, :hgetall, :hincrby, :hkeys, :hlen, :hmget,
  :hmset, :hset, :hsetnx, :hvals, :incr, :incrby, :lindex, :linsert,
  :llen, :lpop, :lpush, :lpushx, :lrange, :lrem, :lset, :ltrim, :move,
  :persist, :publish, :rename, :renamenx, :rpop, :rpoplpush, :rpush,
  :rpushx, :sadd, :scard, :sdiff, :sdiffstore, :set, :setbit, :setex,
  :setnx, :setrange, :sinter, :sinterstore, :sismember, :smembers,
  :smove, :sort, :spop, :srandmember, :srem, :strlen, :subscribe,
  :sunion, :sunionstore, :ttl, :type, :unsubscribe, :watch, :zadd,
  :zcard, :zcount, :zincrby, :zinterstore, :zrange, :zrangebyscore,
  :zrank, :zrem, :zremrangebyrank, :zremrangebyscore, :zrevrange,
  :zrevrangebyscore, :zrevrank, :zscore, :zunionstore]

  attr :redis

  def initialize(key, redis = Redis.current)
    key = key.to_redis_key if key.respond_to?(:to_redis_key)
    super(key)
    @redis = redis
  end

  def [](key)
    key = key.to_redis_key if key.respond_to?(:to_redis_key)
    self.class.new("#{self}:#{key}", redis)
  end

  METHODS.each do |meth|
    define_method(meth) do |*args, &block|
      redis.send(meth, self, *args, &block)
    end
  end
end
