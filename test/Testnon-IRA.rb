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
			[ -396, 2011 ],
			[ -3903, 2012 ],
			[ 23898, 2014 ],
			[ -11697, 2015 ],
			[ -12630, 2016 ],
			[ -17568, 2017 ],
			[ -21732, 2021 ],
			[ -28093, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.sav_spend(year))
		end
	end
	
	def test_non_ira_account
		results = [
			[ 61094, 2011 ],
			[ 58621, 2012 ],
			[ 85013, 2014 ],
			[ 93388, 2017 ],
			[ 79512, 2021 ],
			[ 46795, 2025 ],
			[ 12562, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.non_ira_account(year))
		end				
	end
end