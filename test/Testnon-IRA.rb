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
      [ 838, 2024 ],
      [ -12513, 2026 ],
      [ -15532, 2027 ],
      [ -17115, 2028 ],
      [ -56521, 2046 ]
	]
    results.each do |expense, year| 
      assert_equal(expense, @non_ira_in.sav_spend(year))
    end
  end

  def test_non_ira_account
    results = [
      [ 69348, 2014 ],
      [ 74939, 2015 ],
      [ 87815, 2017 ],
      [ 93846, 2018 ],
      [ 100059, 2019 ],
      [ 105642, 2020 ],
      [ 135931, 2024 ],
      [ 154443, 2026 ],
      [ 155299, 2027 ],
      [ 149023, 2030 ],
      [ 128893, 2033 ],
      [ 118503, 2034 ],
      [ 106027, 2035 ],
      [ 74149, 2037 ],
      [ 31792, 2039 ],
      [ 6166, 2040 ],
      [ -225788, 2046 ]
        ]
    results.each do |expense, year|
      assert_equal(expense, @non_ira_in.non_ira_account(year))
    end
  end
end
