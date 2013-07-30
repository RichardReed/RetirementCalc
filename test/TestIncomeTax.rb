#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'


class TestIncomeTaxMethods < Test::Unit::TestCase
	def setup
		@income_tax_in = IncomeTax.new
	end
	
	def test_income_tax
		results = [
			[ 16146, 2011],
			[ 21783, 2012 ],
			[ 35308, 2014 ],
			[ 25030, 2016 ],
			[ 17568, 2017 ],
			[ 21732, 2021 ],
			[ 24987, 2026 ],
			[ 28093, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @income_tax_in.income_tax(year))
		end		
	end
end