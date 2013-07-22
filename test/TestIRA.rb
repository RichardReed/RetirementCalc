#Test IRA Account methods

require 'test/unit'
require_relative '../lib/IRA'


class TestIRAMethods < Test::Unit::TestCase
	def setup
		@ira_in = IRA.new
	end
	
	def test_ira_spend
		results = [
			[ 0, 2012 ],
			[ 0, 2016 ],
			[ -55902, 2017 ],
			[ -49326, 2020 ],
			[ -35795, 2024 ],
			[ -37229, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_spend(year))
		end				
	end
  
	def test_ira_account
		results = [
            [ 615000, 2011 ],
			[ 630375, 2012 ],
			[ 647425, 2014 ],
            [ 650104, 2016 ],
			[ 594195, 2017 ],
			[ 356884, 2021 ],
			[ 177605, 2024],
			[ 2481, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_account(year))
		end				
	end
end