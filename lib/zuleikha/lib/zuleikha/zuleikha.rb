require 'json'
module Zuleikha
	extend self
  DEFAULT_NAMESPACE = :zul

  def add_to_queue(klass, *args)
    Job.create(klass.to_s, args)
  end

  def redis=(host = '127.0.0.1', port = 6739)
    if host.blank? && port.blank?
      redis = Redis.connect()
    else
      redis = Redis.connect(:host => host, :port => port)
    end

    @redis = Redis::Namespace.new(DEFAULT_NAMESPACE, :redis => redis)    
  end

  def redis(namespace = 'zul')
    return @redis if @redis
    redis = Redis.connect()
    @redis = Redis::Namespace.new(DEFAULT_NAMESPACE, :redis => redis)
  end

  def push(queue, item)
    encoded_item = encode(item)
    puts "Encoded Item #{encoded_item.inspect}"
    redis.rpush("queue:#{queue.to_s}", encoded_item)
  end

  def encode(object)    
    puts "Object to encode #{object.inspect}"
    MultiJson.encode(object)
  end

  def decode(string) 
    puts "Ready to decode "   
    puts string.inspect
    #MultiJson.decode(string)
    JSON.parse(string)
  end

  def fetch_job(queue = :zu)
    data = redis.lpop("queue:#{queue.to_s}")
    puts "Popped Data: #{data.inspect}"
    if data.nil?
      return_val =  data
    else      
      return_val = decode(data)
      puts "Decoded Item: #{return_val}"
    end

    return_val
  end
end
