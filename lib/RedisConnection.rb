class RedisConnection
	require 'redis'

	def initialize(redis_settings)
		@redis =  Redis.new(:host => redis_settings.host_name,
							:port => redis_settings.port,
							:password =>  redis_settings.password)
		@key = redis_settings.key
	end

	def set(options)
		@redis.set(@key,options[:value])
	end

	def get
		@redis.get(@key)
	end
end