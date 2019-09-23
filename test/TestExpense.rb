require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
require_relative '../lib/Expense'


class TestExpenseMethods < Test::Unit::TestCase
  def setup
    @config_hash = ConfigFile.new
    @config_hash.config
    @expenses_in = ExpenseCalc.new
  end

  def test_initial_annual_exp
    assert_equal(48300, @expenses_in.initial_annual_exp)
  end

  def test_initial_annual_med_exp
    assert_equal(12000, @expenses_in.initial_annual_med_exp)
  end

  def test_final_annual_exp
    results = [
      [ 36225, 2014 ],
      [ 49749, 2015 ],
      [ 54792, 2019 ],
      [ 75846, 2030 ],
      [ 78121, 2031 ],
      [ 121710, 2046]
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
      [ 5000, 2033 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @expenses_in.large_exp(year))
    end
  end

  def test_final_annual_med_exp
    results = [
      [ 9000, 2014 ],
      [ 12960, 2015 ],
      [ 41111, 2030 ],
      [ 140840, 2046 ],
    ]
    results.each do |expense, year|
      assert_equal(expense, @expenses_in.annual_med_exp(year))
    end
  end

  def test_gross_exp
    results = [
      [ 45225, 2014 ],
      [ 70709, 2015 ],
      [ 72424, 2019 ],
      [ 111703, 2029 ],
      [ 70174, 2030 ],
      [ 85800, 2033 ],
      [ 157530, 2046]
    ]
    results.each do |expense, year|
      assert_equal(expense, @expenses_in.gross_exp(year))
    end
  end
end
