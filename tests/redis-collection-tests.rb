require 'test/unit'
require 'json'
class RedisCollectionTests < Test::Unit::TestCase

	def test_When_add_is_called_Then_RedisWrapper_is_set_with_json_value_of_object
		item = { x: 0, y: -3 } 
		redis_collection = RedisCollection.new(self)
		redis_collection.add(item)
		assert_equal(item.to_json,@redis_set_value)
	end

	def test_Given_the_redis_store_contains_an_object_When_another_is_added_Then_the_set_command_to_redis_contains_both
		@current_redis_contents = {x:3,y:2}.to_json
		item_2 = {x:5,y:9}
		redis_collection = RedisCollection.new(self)
		redis_collection.add(item_2)		
		assert_equal("#{@current_redis_contents} , #{item_2.to_json}",@redis_set_value)
	end

	def get
		@current_redis_contents
	end 

	def set(item = {})
		@redis_set_value = item
		@redis_set_called = true
	end
end

class RedisCollection
	ITEM_SEPARATOR = " , "

	def initialize(redis_store)
		@redis_store = redis_store
		@collection_serializer = CollectionSerializer.new(@redis_store)
		@items =  []
	end

	def add(item)		
		@items = @collection_serializer.deserialize
		@items.push(item)
		@collection_serializer.serialize(@items)
	end
end

class CollectionSerializer
	ITEM_SEPARATOR = " , "
	def initialize(redis_wrapper)
		@redis_wrapper = redis_wrapper
	end

	def serialize(collection)
		json_collection = collection.map do |item|
			item.to_json
		end
		json_string = json_collection.join(ITEM_SEPARATOR)
		@redis_wrapper.set(json_string)
	end

	def deserialize
		json_string =  @redis_wrapper.get || ""
		redis_contents = json_string.split(ITEM_SEPARATOR)
		redis_contents.map do |item|
			JSON.parse(item, :symbolize_names => true)
		end
	end
end