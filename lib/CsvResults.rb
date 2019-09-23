# For all years up to 100, this calls the method which produces each 
# result of interest and places them in the CvsResults.cvs file

require 'csv'
require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'Expense'
require_relative 'IncomeTax'
require_relative 'IRA'
require_relative 'non-IRA'

class CsvResults

  def initialize
    @config_hash = ConfigFile.new
    @current_year = @config_hash.config['starting_year']
    @income_in = IncomeCalc.new
    @income_tax_in = IncomeTax.new
    @expenses_in = ExpenseCalc.new
    @non_ira_in = NonIRA.new
    @ira_in = IRA.new
  end

  def results_table(starting_age, final_age)
    CSV.open('../lib/CsvResults.csv', 'w' 
    ) do |results|
      results << ["Age","Year","Income","Taxable Income","Taxes",
                 "Exp Non-medical","Exp medical","Large Items", 
                 "Total Spending","IRA Savings","Non-IRA Savings",
                 "Total Savings"]
      (starting_age..final_age).each do |age|
        year = age + 1954
        results << [age, year, 
                 @income_in.gross_income(year),
                 @income_tax_in.taxable_income(year),
                 @income_tax_in.income_tax(year),
                 @expenses_in.annual_exp(year),
                 @expenses_in.annual_med_exp(year),
                 @expenses_in.large_exp(year),
                 @expenses_in.gross_exp(year),
                 @ira_in.ira_account(year),
                 @non_ira_in.non_ira_account(year),
                 @ira_in.ira_account(year) + 
                 @non_ira_in.non_ira_account(year)]
      end #each do
    end #open do
  end #results_table

  if __FILE__==$0 #only executes if run from command line
    print 'Please enter youngest age in table:  ' 
    starting_age = gets.to_i 
    print 'Please enter oldest age in table:  ' 
    final_age = gets.to_i 
    @csv_results = CsvResults.new 
    @csv_results.results_table(starting_age, final_age) 
  end
end
