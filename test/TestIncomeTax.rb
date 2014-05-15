#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'


class TestIncomeTaxMethods < Test::Unit::TestCase
	def setup
		@income_tax_in = IncomeTax.new
	end
	
	def test_income_tax
		results = [
			[ 4943, 2014 ],
            [ 8858, 2018 ],
			[ 9594, 2020 ],  
            [ 10848, 2022 ],    # starts 25% tax bracket
			[ 24200, 2033 ],
			[ 56521, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @income_tax_in.income_tax(year))
		end		
	end
end