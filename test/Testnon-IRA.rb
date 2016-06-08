#Test non-IRA Methods

require 'test/unit'
require_relative '../lib/non-IRA'


class TestNonIRAMethods < Test::Unit::TestCase
  def setup
    @non_ira_in = NonIRA.new
    @results_file = YAML::load(File.open("results.yml"))
  end

  def test_non_ira_sav_spend
    results = [
      [ -4943, 2014 ],
      [ -8430, 2017 ],
      [ -8858, 2018 ],
      [ -8827, 2019 ],
      [ -11757, 2023 ],
      [ 346, 2024 ],
      [ -12922, 2026 ],
      [ -15923, 2027 ],
      [ -17115, 2028 ],
      [ -56521, 2046 ]
	]
    results.each do |expense, year| 
      assert_equal(expense, @non_ira_in.sav_spend(year))
    end
  end

  def test_non_ira_account
    results = [
      [ 79307, 2014 ],
      [ 143631, 2024 ],
      [ 120582, 2034 ],
      [ -222083, 2046 ]
        ]
    results.each do |expense, year|
      assert_equal(expense, @non_ira_in.non_ira_account(year))
    end
  end
end
