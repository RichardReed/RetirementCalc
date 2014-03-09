#Test non-IRA Methods

require 'test/unit'
require_relative '../lib/non-IRA'


class TestNonIRAMethods < Test::Unit::TestCase
	def setup
		@non_ira_in = NonIRA.new
		@results_file = YAML::load(File.open("results.yml"))
	end
	
	def test_non_ira_sav_spend
		results = [
			[ -4943, 2014 ],
            [ -8430, 2017 ],
            [ -8858, 2018 ],
			[ -11757, 2023 ],
			[ 838, 2024 ],
            [ -12513, 2026 ],
			[ -15532, 2027 ],
			[ -17115, 2028 ],
			[ -56521, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.sav_spend(year))
		end
	end
	
	def test_non_ira_account
		results = [
			[ 69348, 2014 ],
            [ 74939, 2015 ],
            [ 87815, 2017 ],
            [ 93846, 2018 ],
            [ 99752, 2019 ],
            [ 105327, 2020 ],
            [ 135583, 2024 ],
            [ 154077, 2026 ],
			[ 154924, 2027 ],
            [ 148619, 2030 ],
            [ 128457, 2033 ],
            [ 118056, 2034 ],
            [ 105569, 2035 ],
            [ 73667, 2037 ],
			[ 31286, 2039 ],
			[ 5648, 2040 ],
			[ -226390, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.non_ira_account(year))
		end				
	end
end