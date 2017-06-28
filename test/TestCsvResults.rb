#Tests the CsvResults.rb

require 'csv'
require 'test/unit'
require_relative '../lib/CsvResults'

class TestCsvResults < Test::Unit::TestCase

  def setup
    @csv_results = CsvResults.new
    @csv_results.results_table(60, 76)
  end
	
  def test_csv_file
    assert_equal((false), File.zero?('../lib/CsvResults.csv'))
    table = CSV.read('../lib/CsvResults.csv')
    assert_equal((["Age","Year","Income","Taxable Income","Taxes",
                  "Exp Non-medical","Exp medical","Large Items", 
                  "Total Spending","IRA Savings","Non-IRA Savings",
                  "Total Savings"]), table[0])
    assert_equal((["60","2014","31950","54225.0","4211","36225.0",
                  "9000.0","0","45225.0","592168","76378",
                  "668546"]), table[1])
    assert_equal((["76","2030","66248","77174","7654","75846",
                    "41111","0","70174","492386","120087",
                    "612473"]), table[17])
  end #test_csv_file
end
