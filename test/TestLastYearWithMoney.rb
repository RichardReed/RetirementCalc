#Test LastYearWithMoney.rb
#Also tests MoneyRanOut.rb

require 'yaml'
require 'test/unit'
require_relative '../lib/LastYearWithMoney'
require_relative '../lib/Config'

class TestLastYearWithMoney < Test::Unit::TestCase

  def setup
    r = File.open('Results.yml','w')
    r.close
    @last_year_with_money = LastYearWithMoney.new
    @last_year_with_money.year_last_with_money
    @finalyr = YAML::load(File.open("results.yml"))
  end
	
  def test_last_year_with_money
    assert_equal(2045, @finalyr[:year])
    assert_equal(91, @finalyr[:age])
    assert_equal(85781, @finalyr[:income])  #Gross Income
    assert_equal(26174, @finalyr[:taxes])
    assert_equal(118165, @finalyr[:exp_other_than_medical])
    assert_equal(130407, @finalyr[:medical_expenses])
    assert_equal(9025, @finalyr[:ira_savings])
    assert_equal(54072, @finalyr[:non_ira_savings])
  end
end
