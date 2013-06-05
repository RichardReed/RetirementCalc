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
			[ -983, 2011 ],
			[ 23555, 2014 ],
			[ -12047, 2015 ],
			[ -12987, 2016 ],
			[ -17753, 2017 ],
			[ -21924, 2021 ],
			[ -28300, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.sav_spend(year))
		end
	end
	
	def test_non_ira_account
		results = [
			[ 60492, 2011 ],
			[ 57793, 2012 ],
			[ 84082, 2014 ],
			[ 93021, 2017 ],
			[ 80433, 2021 ],
			[ 15977, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @non_ira_in.non_ira_account(year))
		end				
	end
end