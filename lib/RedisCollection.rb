require_relative "CollectionSerializer"
class RedisCollection
	
	def initialize(redis_connection)
		@redis_connection = redis_connection
		@collection_serializer = CollectionSerializer.new(redis_connection)	
	end

	def add(item)		
		@items = @collection_serializer.deserialize
		@items.push(item)
		@collection_serializer.serialize(@items)
	end

	def get		
		@collection_serializer.deserialize()
	end

end