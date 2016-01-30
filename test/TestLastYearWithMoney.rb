#Test LastYearWithMoney.rb

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
		assert_equal(2039, @finalyr[:year])
		assert_equal(85, @finalyr[:age])
		assert_equal(131527, @finalyr[:income])
		assert_equal(35963, @finalyr[:taxes])
		assert_equal(102522, @finalyr[:exp_other_than_medical])
		assert_equal(82179, @finalyr[:medical_expenses])
		assert_equal(40095, @finalyr[:ira_savings])
		assert_equal(29219, @finalyr[:non_ira_savings])
	end
end
