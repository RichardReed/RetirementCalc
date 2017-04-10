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
      [ -4751, 2014 ],
      [ -8152, 2017 ],
      [ -8571, 2018 ],
      [ -8531, 2019 ],
      [ -11202, 2023 ],
      [ 2632, 2024 ],
      [ -10498, 2026 ],
      [ -13453, 2027 ],
      [ -16473, 2028 ],
      [ -55426, 2046 ]
	]
    results.each do |expense, year| 
      assert_equal(expense, @non_ira_in.sav_spend(year))
    end
  end

  def test_non_ira_account
    results = [
      [ 79503, 2014 ],
      [ 149688, 2024 ],
      [ 142162, 2034 ],
      [ -181500, 2046 ]
        ]
    results.each do |expense, year|
      assert_equal(expense, @non_ira_in.non_ira_account(year))
    end
  end
end
