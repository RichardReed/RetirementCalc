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
      [ -4211, 2014 ],
      [ -10302, 2023 ],
      [ 3532, 2024 ],
      [ -9598, 2026 ],
      [ -12553, 2027 ],
      [ -15573, 2028 ],
      [ -7654, 2030 ],
      [ -14714, 2038 ],
      [ -28271, 2046 ]
	]
    results.each do |expense, year| 
      assert_equal(expense, @non_ira_in.sav_spend(year))
    end
  end

  def test_non_ira_account
    results = [
      [ 76378, 2014 ],
      [ 111850, 2024 ],
      [ 128669, 2034 ],
      [ 35541, 2046 ]
        ]
    results.each do |expense, year|
      assert_equal(expense, @non_ira_in.non_ira_account(year))
    end
  end
end
