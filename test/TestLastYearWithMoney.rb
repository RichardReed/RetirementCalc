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
    assert_equal(2040, @finalyr[:year])
    assert_equal(86, @finalyr[:age])
    assert_equal(134076, @finalyr[:income])
    assert_equal(37459, @finalyr[:taxes])
    assert_equal(101930, @finalyr[:exp_other_than_medical])
    assert_equal(88753, @finalyr[:medical_expenses])
    assert_equal(46930, @finalyr[:ira_savings])
    assert_equal(37076, @finalyr[:non_ira_savings])
  end
end
