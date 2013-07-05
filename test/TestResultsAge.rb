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
		@final_results.results_for(69)
		@finalyr = YAML::load(File.open("results.yml"))
	end
	
	def test_retirement_fund_program_age
		assert_equal(2023, @finalyr[:year])
		assert_equal(69, @finalyr[:age])
		assert_equal(72303, @finalyr[:income])
		assert_equal(24502, @finalyr[:taxes])
		assert_equal(101590, @finalyr[:exp_other_than_medical])
		assert_equal(31419, @finalyr[:medical_expenses])
		assert_equal(215810, @finalyr[:ira_savings])
		assert_equal(66170, @finalyr[:non_ira_savings])
	end
end