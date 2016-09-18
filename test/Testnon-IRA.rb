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
      [ -8431, 2017 ],
      [ -8858, 2018 ],
      [ -8827, 2019 ],
      [ -11758, 2023 ],
      [ 342, 2024 ],
      [ -12926, 2026 ],
      [ -15924, 2027 ],
      [ -17116, 2028 ],
      [ -56522, 2046 ]
	]
    results.each do |expense, year| 
      assert_equal(expense, @non_ira_in.sav_spend(year))
    end
  end

  def test_non_ira_account
    results = [
      [ 79307, 2014 ],
      [ 143621, 2024 ],
      [ 120551, 2034 ],
      [ -222135, 2046 ]
        ]
    results.each do |expense, year|
      assert_equal(expense, @non_ira_in.non_ira_account(year))
    end
  end
end
