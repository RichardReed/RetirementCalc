#Test MoneyRanOut.rb

require 'yaml'
require 'test/unit'
require_relative '../lib/MoneyRanOut'
require_relative '../lib/Config'

class TestMoneyRanOut < Test::Unit::TestCase

	def setup
		r = File.open('Results.yml','w')
		r.close
		@money_ran_out = MoneyRanOut.new
		@money_ran_out.final_year_results
		@finalyr = YAML::load(File.open("results.yml"))
	end
	
		def test_money_ran_out
		assert_equal(2029, @finalyr[:year])
		assert_equal(75, @finalyr[:age])
		assert_equal(112783, @finalyr[:income])
		assert_equal(29779, @finalyr[:taxes])
		assert_equal(104755, @finalyr[:exp_other_than_medical])
		assert_equal(49859, @finalyr[:medical_expenses])
		assert_equal(-55196, @finalyr[:ira_savings])
		assert_equal(-2785, @finalyr[:non_ira_savings])
	end
end