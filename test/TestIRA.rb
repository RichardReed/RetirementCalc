#Test IRA Account methods

require 'test/unit'
require_relative '../lib/IRA'


class TestIRAMethods < Test::Unit::TestCase
  def setup
    @ira_in = IRA.new
  end
	
  def test_ira_spend
    results = [
      [ -14553, 2014 ],
      [ -20550, 2019 ],
      [ -16119, 2023 ],
      [ 0, 2024 ],
      [ 0, 2026 ],
      [ -38, 2027 ],
      [ -116481, 2046]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @ira_in.ira_spend(year))
    end				
  end
  
  def test_ira_account
    results = [
      [ 587168, 2014 ],
      [ 482749, 2019 ],
      [ 415850, 2024 ],
      [ 413331, 2025 ],
      [ 410749, 2026 ],
      [ 408064, 2027 ],
      [ 402495, 2028 ],
      [ -712744, 2046 ]
    ]
    results.each do |expense, year| 
      assert_equal(expense, @ira_in.ira_account(year))
    end				
  end
end
