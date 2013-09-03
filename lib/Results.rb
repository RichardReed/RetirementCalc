# For the specified year or age, places the results in the Results.yml file

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'Expense'
require_relative 'IncomeTax'
require_relative 'IRA'
require_relative 'non-IRA'

class Results

    def initialize
        @config_hash = ConfigFile.instance
        @current_year = @config_hash.config['starting_year']
        @income_in = IncomeCalc.new
        @income_tax_in = IncomeTax.new
        @expenses_in = ExpenseCalc.new
        @non_ira_in = NonIRA.new
        @ira_in = IRA.new
    end

    def results_for(final_age_year)
        if final_age_year < 120
            final_year = final_age_year.is_year
            final_age = final_age_year
        else
            final_year = final_age_year
            final_age = final_age_year.is_age
        end
        results = File.open('Results.yml', 'w')
        YAML.dump({
            :year => final_year,
            :age => final_age,
            :income => @income_in.gross_income(final_year),
            :taxes => @income_tax_in.income_tax(final_year),
            :exp_other_than_medical => @expenses_in.annual_exp(final_year),
            :medical_expenses => @expenses_in.annual_med_exp(final_year),
            :ira_savings => @ira_in.ira_account(final_year),
            :non_ira_savings => @non_ira_in.non_ira_account(final_year) },
            results)
        results.close
    end

end
