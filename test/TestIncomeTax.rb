#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'


class TestIncomeTaxMethods < Test::Unit::TestCase
	def setup
		@income_tax_in = IncomeTax.new
	end
	
	def test_income_tax
		results = [
			[ 19774, 2011],
			[ 21783, 2012 ],
			[ 35433, 2014 ],
			[ 25155, 2016 ],
			[ 17753, 2017 ],
			[ 21924, 2021 ],
			[ 28300, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @income_tax_in.income_tax(year))
		end		
	end
end