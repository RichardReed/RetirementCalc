require 'yaml'
require 'test/unit'
require_relative '../lib/Config'
require_relative '../lib/Income'


class TestIncomeMethods < Test::Unit::TestCase
  def setup
    @config_hash = ConfigFile.new
    @config_hash.config
    @income_in = IncomeCalc.new
  end

  def test_navy_ret_income
    results = [
      [ 39600, 2014 ],
      [ 40392, 2015 ],
      [ 74626, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.navy_ret_income(year))
    end
  end

  def test_ge_pension_income
    results = [
      [ 3000, 2014 ],
      [ 3045, 2015 ],
      [ 4828, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.ge_pension_income(year))
    end
  end

  def test_alc_pension_start_year
    assert_equal(2017, @income_in.alc_pension_start_year)
  end

  def test_alc_pension_income
    results = [
      [ 0, 2016 ],
      [ 4800, 2017 ],
      [ 6404, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.alc_pension_income(year))
    end
  end

  def test_ss_start_year
    assert_equal(2024, @income_in.ss_start_year)
  end

  def test_ss_income
    results = [
      [ 0, 2023 ],
      [ 36000, 2024 ],
      [ 36720, 2025 ],
      [ 29963, 2026 ],
      [ 44522, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.ss_income(year))
    end
  end

  def test_spouse_ss_start_year
    assert_equal(2020, @income_in.spouse_ss_start_year)
  end

  def test_new_spouse_ss_start_year
    assert_equal(2022, @income_in.new_spouse_ss_start_year)
  end

  def test_spouse_ss_income
    results = [
      [ 0, 2019 ],
      [ 12000, 2020 ],
      [ 12240, 2021 ],
      [ 15600, 2022 ],
      [ 16555, 2025 ],
      [ 13509, 2026 ],
      [ 14335, 2029 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.ss_spouse_income(year))
    end
  end

  def test_lump_sum_income
    results = [
      [ 0, 2017 ],
      [ 9000, 2018 ],
      [ 0, 2019 ],
      [ 6000, 2036 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.lump_sum_income(year))
    end
  end

  def test_life_insurance_income
    results = [
      [ 0, 2019 ],
      [ 0, 2029 ],
      [ 2000, 2030 ],
      [ 0, 2031 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.life_insurance_income(year))
    end
  end

  def test_gross_income
    results = [
      [ 31950, 2014 ],
      [ 43437, 2015 ],
      [ 59896, 2018 ],
      [ 51849, 2019 ],
      [ 109128, 2024 ],
      [ 108585, 2029 ],
      [ 66248, 2030 ],
      [ 87451, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @income_in.gross_income(year))
    end
  end
end
