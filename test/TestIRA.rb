#Test IRA Account methods

require 'test/unit'
require_relative '../lib/IRA'


class TestIRAMethods < Test::Unit::TestCase
  def setup
    @config_hash = ConfigFile.new
    @config_hash.config
    @ira_in = IRA.new
  end

  def test_ira_spend
    results = [
      [ -13275, 2014 ],
      [ -20575, 2019 ],
      [ -13896, 2023 ],
      [ 0, 2024 ],
      [ 0, 2027 ],
      [ -211, 2028 ],
      [ -3118, 2029 ],
      [ -3926, 2030 ],
      [ -28355, 2038 ],
      [ -70079, 2046]
    ]
    results.each do |expense, year|
      assert_equal(expense, @ira_in.ira_spend(year))
    end
  end

  def test_ira_account
    results = [
      [ 592168, 2014 ],
      [ 515776, 2019 ],
      [ 479133, 2023 ],
      [ 481886, 2024 ],
      [ 490566, 2027 ],
      [ 493389, 2028 ],
      [ 493303, 2029 ],
      [ 492386, 2030 ],
      [ 367623, 2038 ],
      [ -71805, 2046 ]
    ]
    results.each do |expense, year|
      assert_equal(expense, @ira_in.ira_account(year))
    end
  end
end
