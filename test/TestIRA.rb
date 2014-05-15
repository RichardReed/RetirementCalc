#Test IRA Account methods

require 'test/unit'
require_relative '../lib/IRA'


class TestIRAMethods < Test::Unit::TestCase
	def setup
		@ira_in = IRA.new
	end
	
	def test_ira_spend
		results = [
			[ -14550, 2014 ],
			[ -15472, 2023 ],
			[ 0, 2024 ],
			[ 0, 2027 ],
			[ -2214, 2028 ],
            [ -115665, 2046]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_spend(year))
		end				
	end
  
	def test_ira_account
		results = [
			[ 587171, 2014 ],
			[ 423055, 2024 ],
            [ 411074, 2028 ],
			[ -683667, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_account(year))
		end				
	end
end