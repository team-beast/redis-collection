require 'test/unit'
require 'json'
require_relative '../lib/RedisCollection'
class RedisCollectionAddTests < Test::Unit::TestCase
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