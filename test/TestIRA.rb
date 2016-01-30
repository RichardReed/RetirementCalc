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
                        [ -20546, 2019 ],
			[ -16115, 2023 ],
			[ 0, 2024 ],
			[ 0, 2026 ],
			[ -34, 2027 ],
                        [ -116477, 2046]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_spend(year))
		end				
	end
  
	def test_ira_account
		results = [
			[ 587171, 2014 ],
                        [ 482773, 2019 ],
			[ 415895, 2024 ],
                        [ 413377, 2025 ],
                        [ 410796, 2026 ],
                        [ 408116, 2027 ],
                        [ 402552, 2028 ],
			[ -712565, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @ira_in.ira_account(year))
		end				
	end
end
