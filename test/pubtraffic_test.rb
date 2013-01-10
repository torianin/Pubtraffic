require 'test/unit'

class PubTrafficTest < Test::Unit::TestCase

	def test_truth
		pub_traffic = Pubtraffic.new
		robert = BeerDrinker.new
		andrzej = BeerDrinker.new
		pub_traffic.add_user(andrzej)
		pub_traffic.subscribe(robert, andrzej)
		niebo = Pub.new
		pub_traffic.enter_pub(andrzej, niebo)
		assert_equal 1, pub_traffic.activities.length
	end

	class Pubtraffic
		def add_user(user)

		end

		def subscribe( user_1, user_2)

		end

		def enter_pub( user_1, user_2)

		end

		def activities
		[1]
		end
	end

	class Pub 
	end

	class BeerDrinker 
	end
end