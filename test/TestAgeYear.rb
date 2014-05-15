require 'test/unit'
require_relative '../lib/AgeYear'

class TestAgeYear < Test::Unit::TestCase
		
	def test_is_age
		assert_equal(60, 2014.is_age)
	end
	
	def test_is_year
		assert_equal(2014, 60.is_year)
	end
end