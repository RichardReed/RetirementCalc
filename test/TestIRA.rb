#Test IRA Account methods

require 'test/unit'
require_relative '../lib/IRA'


class TestIRAMethods < Test::Unit::TestCase
  def setup
    @ira_in = IRA.new
  end
	
  def test_ira_spend
    results = [
      [ -13275, 2014 ],
      [ -18575, 2019 ],
      [ -13896, 2023 ],
      [ 0, 2024 ],
      [ 0, 2026 ],
      [ 0, 2027 ],
      [ -211, 2028 ],
      [ -112096, 2046 ]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @ira_in.ira_spend(year))
    end				
  end
  
  def test_ira_account
    results = [
      [ 588478, 2014 ],
      [ 494255, 2019 ],
      [ 438140, 2024 ],
      [ 436178, 2025 ],
      [ 434167, 2026 ],
      [ 432106, 2027 ],
      [ 429777, 2028 ],
      [ -592561, 2046 ]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @ira_in.ira_account(year))
    end				
  end
end
