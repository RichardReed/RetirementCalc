#Tests the Results.rb

require 'yaml'
require 'test/unit'
require_relative '../lib/Results'
require_relative '../lib/Config'

class TestRetirementFundProgramAge < Test::Unit::TestCase

	def setup
		r = File.open('Results.yml','w')
		r.close
		@final_results = Results.new
		@final_results.results_for(90)
		@finalyr = YAML::load(File.open("results.yml"))
	end
	
	def test_retirement_fund_program_age
		assert_equal(2044, @finalyr[:year])
		assert_equal(90, @finalyr[:age])
		assert_equal(145561, @finalyr[:income])
		assert_equal(49688, @finalyr[:taxes])
		assert_equal(118852, @finalyr[:exp_other_than_medical])
		assert_equal(120747, @finalyr[:medical_expenses])
		assert_equal(-404748, @finalyr[:ira_savings])
		assert_equal(-131665, @finalyr[:non_ira_savings])
	end
end
