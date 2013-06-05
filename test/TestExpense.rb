require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
require_relative '../lib/Expense'


class TestExpenseMethods < Test::Unit::TestCase
	def setup
		@config_hash = ConfigFile.instance
		@expenses_in = ExpenseCalc.new
	end
	
	def test_starting_exp
		assert_equal(5600, @expenses_in.starting_monthly_exp)
	end
	
	def test_starting_annual_exp
		assert_equal(72200, @expenses_in.starting_annual_exp)
	end
	
	def test_starting_annual_med_exp
		assert_equal(12000, @expenses_in.starting_annual_med_exp)
	end
	
	def test_final_annual_exp
		results = [
			[ 72200, 2011 ],
			[ 74366, 2012 ],
			[ 76597, 2013 ],  
			[ 78895, 2014 ],
			[ 88797, 2018 ],
			[ 90261, 2019 ],
			[ 104638, 2024 ],
			[ 102035, 2028 ]
		]
		results.each do |expense, year| 
			assert_equal(expense, @expenses_in.annual_exp(year))
		end
	end
	
  def test_final_large_exp
		results = [
      [ 0, 2012 ],
      [ 8000, 2013 ],  
      [ 0, 2014 ],
		]
		results.each do |expense, year| 
			assert_equal(expense, @expenses_in.large_exp(year))
		end
	end
  
	def test_final_annual_med_exp
		results = [
			[ 13997, 2013 ],
			[ 15717, 2014 ],
			[ 26937, 2021 ],
		]
		results.each do |expense, year| 
			assert_equal(expense, @expenses_in.annual_med_exp(year)) 
		end
	end
	
	def test_gross_exp
		assert_equal(98594, @expenses_in.gross_exp(2013))
		assert_equal(148201, @expenses_in.gross_exp(2028))
	end
end