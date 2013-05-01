class RedisSettings
	attr_accessor :host, :port, :password, :key
	def initialize(options)
		@host = options[:host]
		@port = options[:port]
		@password = options[:password]
		@key = options[:key]
	end
end