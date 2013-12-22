#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'


class TestIncomeTaxMethods < Test::Unit::TestCase
	def setup
		@income_tax_in = IncomeTax.new
	end
	
    # def test_income
        # results = [
            # [ 59100, 2014 ],
            # [ 85201, 2018 ],
            # [ 86995, 2019 ],
			# [ 90109, 2020 ],
			# [ 150248, 2033 ],
			# [ 279531, 2046 ]
		# ]
		# results.each do |income, year| 
			# assert_equal(income, @income_tax_in.income(year))
        # end
    # end
    
	def test_income_tax
		results = [
			[ 5165, 2014 ],
            [ 9080, 2018 ],
			[ 10027, 2020 ],  # starts 25% tax bracket
			[ 25062, 2033 ],
			[ 57383, 2046 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @income_tax_in.income_tax(year))
		end		
	end
end