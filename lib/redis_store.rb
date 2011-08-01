require 'redis'
require 'set'

class RedisStore
  
  Entry = Struct.new(:votes, :value, :idx)
  
  KEY_ENTRIES = "faselcharts_entries"
  
  def initialize
    @redis = Redis.connect(:url => ENV['REDISTOGO_URL'])
  end
  
  def list()
    @redis.zrangebyscore(KEY_ENTRIES, '-inf', '+inf', :with_scores => true).reverse.each_slice(2).map{|votes, value| Entry.new(votes, value)}
  end

  def add(value)
    @redis.zadd(KEY_ENTRIES, 1, value)
    Entry.new(1, value)
  end
  
  def vote(value)
    return unless @redis.zscore(KEY_ENTRIES, value)
    @redis.zincrby(KEY_ENTRIES, 1, value)
  end
  
  def clear()
    @redis.del KEY_ENTRIES
  end
end