#Test IncomeTaxes.rb

require 'test/unit'
require_relative '../lib/IncomeTax'

class TestIncomeTaxMethods < Test::Unit::TestCase
  def setup
    @income_tax_in = IncomeTax.new
  end
	
  def test_income_tax
    results = [
      [ 4211, 2014 ],    # 15% tax bracket
      [ 8031, 2018 ],    # 15% tax bracket
      [ 8291, 2019 ],    # 15% tax bracket
      [ 9740, 2022 ],    # 15% tax bracket
      [ 10302, 2023 ],   # 25% tax bracket
      [ 16814, 2029 ],   # 25% tax bracket
      [ 7654, 2030 ],    # 15% tax bracket
      [ 10338, 2033 ],   # 25% tax bracket
      [ 10144, 2034 ],   # 15% tax bracket
      [ 11138, 2035 ],   # 25% tax bracket
      [ 28271, 2046 ]    # 25% tax bracket
    ]
    results.each do |expense, year| 
      assert_equal(expense, @income_tax_in.income_tax(year))
    end		
  end
end
