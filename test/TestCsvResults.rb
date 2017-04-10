#Tests the CsvResults.rb

require 'csv'
require 'test/unit'
require_relative '../lib/CsvResults'

class TestCsvResults < Test::Unit::TestCase

  def setup
    @csv_results = CsvResults.new
    @csv_results.results_table(60, 75)
  end
	
  def test_csv_file
    assert_equal((false), File.zero?('../lib/CsvResults.csv'))
    table = CSV.read('../lib/CsvResults.csv')
    assert_equal((["Age","Year","Income","Taxable Income","Taxes",
                  "Exp Non-medical","Exp medical","Large Items", 
                  "Total Spending","IRA Savings","Non-IRA Savings",
                  "Total Savings"]), table[0])
    assert_equal((["60","2014","31950.0","57825.0","4751","36225.0",
                  "9000.0","0","45225.0","588478","79503",
                  "667981"]), table[1])
    assert_equal((["75","2029","108585","124303","17714","73637",
                    "38066","0","111703","424410","172661",
                    "597071"]), table[16])
  end #test_csv_file
end
