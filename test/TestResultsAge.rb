#Tests the Results.rb

require 'yaml'
require 'test/unit'
require_relative '../lib/Results'
require_relative '../lib/Config'

class TestRetirementFundProgramAge < Test::Unit::TestCase

  def setup
    @final_results = Results.new
    @final_results.results_for(90)
    @finalyr = YAML::load(File.open("results.yml"))
  end
	
  def test_retirement_fund_program_age
    assert_equal(2044, @finalyr[:year])
    assert_equal(90, @finalyr[:age])
    assert_equal(84141, @finalyr[:income])  #Gross Income
    assert_equal(24209, @finalyr[:taxes])
    assert_equal(114723, @finalyr[:exp_other_than_medical])
    assert_equal(120747, @finalyr[:medical_expenses])
    assert_equal(81167, @finalyr[:ira_savings])
    assert_equal(70121, @finalyr[:non_ira_savings])
  end
end
