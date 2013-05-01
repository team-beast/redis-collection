class CollectionSerializer
	ITEM_SEPARATOR = " , "
	def initialize(redis_connection)
		@redis_connection = redis_connection
	end

	def serialize(collection)
		json_collection = collection.map do |item|
			item.to_json
		end
		json_string = json_collection.join(ITEM_SEPARATOR)
		@redis_connection.set(json_string)
	end

	def deserialize
		json_string =  @redis_connection.get || ""
		redis_contents = json_string.split(ITEM_SEPARATOR)
		redis_contents.map do |item|
			JSON.parse(item, :symbolize_names => true)
		end
	end
end