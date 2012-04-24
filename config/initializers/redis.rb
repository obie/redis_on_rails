# config/initializers/redis.rb
$redis = Redis.new(:host => 'localhost', :port => 9999)

# tsk, tsk - use to_param instead of to_s as key
# use our $redis instance as default
Nest.class_eval do
  def initialize(key, redis = $redis)
    super(key.to_param)
    @redis = redis
  end

  def [](key)
    # potential gotchas with slugged models
    self.class.new("#{self}:#{key.to_param}", redis)
  end
end
