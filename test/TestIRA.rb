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
			[ -56141, 2017 ],
			[ -49587, 2020 ],
			[ -36089, 2024 ],
			[ -37560, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_spend(year))
		end				
	end
  
	def test_ira_account
		results = [
            [ 615000, 2011 ],
			[ 630375, 2012 ],
			[ 646912, 2014 ],
            [ 648528, 2016 ],
			[ 591822, 2017 ],
			[ 351042, 2021 ],
			[ 168839, 2024],
			[ -10671, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_account(year))
		end				
	end
end