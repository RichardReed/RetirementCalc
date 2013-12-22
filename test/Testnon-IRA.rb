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
			[ -5165, 2014 ],
            [ -8653, 2017 ],
            [ -9080, 2018 ],
			[ -12619, 2023 ],
			[ -24, 2024 ],
			[ -16394, 2027 ],
			[ -17977, 2028 ],
			[ -57383, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.sav_spend(year))
		end
	end
	
	def test_non_ira_account
		results = [
			[ 69121, 2014 ],
            [ 74479, 2015 ],
            [ 86870, 2017 ],
            [ 92650, 2018 ],
            [ 98299, 2019 ],
            [ 103394, 2020 ],
			[ 146078, 2027 ],
			[ 7201, 2039 ],
			[ -19923, 2040 ],
			[ -261689, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.non_ira_account(year))
		end				
	end
end