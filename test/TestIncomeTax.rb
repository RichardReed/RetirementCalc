#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'

class TestIncomeTaxMethods < Test::Unit::TestCase
  def setup
    @income_tax_in = IncomeTax.new
  end
	
  def test_income_tax
    results = [
      [ 4751, 2014 ],
      [ 8571, 2018 ],
      [ 8531, 2019 ],
      [ 9289, 2020 ],  
      [ 10309, 2022 ],    # starts 25% tax bracket
      [ 23455, 2033 ],
      [ 55426, 2046 ]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @income_tax_in.income_tax(year))
    end		
  end
end
