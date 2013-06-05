#Tests the Results.rb

require 'yaml'
require 'test/unit'
require_relative '../lib/Results'
require_relative '../lib/Config'

class TestRetirementFundProgramYear < Test::Unit::TestCase

	def setup
		r = File.open('Results.yml','w')
		r.close
		@final_results = Results.new
		@final_results.results_for(2028)
		@finalyr = YAML::load(File.open("results.yml"))
	end
	
	def test_retirement_fund_program_year
		assert_equal(74, @finalyr[:age])
	end
	
end