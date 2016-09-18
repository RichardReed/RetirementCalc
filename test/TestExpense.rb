require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
require_relative '../lib/Expense'


class TestExpenseMethods < Test::Unit::TestCase
  def setup
    @config_hash = ConfigFile.new
    @expenses_in = ExpenseCalc.new
  end

  def test_starting_annual_exp
    assert_equal(50004, @expenses_in.starting_annual_exp)
  end
	
  def test_starting_annual_med_exp
    assert_equal(12000, @expenses_in.starting_annual_med_exp)
  end
	
  def test_final_annual_exp
    results = [
      [ 37503, 2014 ],
      [ 51504, 2015 ],
      [ 56767, 2019 ],
      [ 126095, 2046]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @expenses_in.annual_exp(year))
    end
  end
	
  def test_final_large_exp
    results = [
      [ 0, 2014 ],
      [ 8000, 2015 ],  
      [ 0, 2016 ],
    ]
    results.each do |expense, year| 
      assert_equal(expense, @expenses_in.large_exp(year))
    end
  end
  
  def test_final_annual_med_exp
    results = [
      [ 9000, 2014 ],
      [ 12960, 2015 ],
      [ 140840, 2046 ],
    ]
    results.each do |expense, year| 
      assert_equal(expense, @expenses_in.annual_med_exp(year)) 
    end
  end
	
  def test_gross_exp
    results = [
      [ 46503, 2014 ],
      [ 72464, 2015 ],
      [ 74399, 2019 ],
      [ 266935, 2046]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @expenses_in.gross_exp(year)) 
    end
  end
end
