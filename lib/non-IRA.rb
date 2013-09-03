# Calculate amount in non-IRA savings accounts.
# All spent savings is taken from non-IRA accounts before age 60.
# All savings is put into non-IRA accounts at any time.
# All taxes on money taken out of IRA accounts.

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'Expense'
require_relative 'IncomeTax'

class NonIRA

    def initialize
        @config_hash = ConfigFile.instance
        @current_year = @config_hash.config['starting_year']
        @income_in = IncomeCalc.new
        @expenses_in = ExpenseCalc.new
        @income_tax_in = IncomeTax.new
    end

    def sav_spend(this_year)
        income_expenses = @income_in.gross_income(this_year) -
            @expenses_in.gross_exp(this_year)
        save_spend = @income_in.gross_income(this_year) -
            @expenses_in.gross_exp(this_year) -
            @income_tax_in.income_tax(this_year)
        income_tax = -@income_tax_in.income_tax(this_year)

        if this_year < 60.is_year
            return save_spend
        elsif income_expenses > 0
            return  save_spend
        else
            return income_tax
        end
    end

    def non_ira_account(final_year)
        this_year = @current_year
        non_ira_account_value = @config_hash.config['starting_non_ira'] +
                                @config_hash.config['life_insurance']
        ira_to_non_ira_xfer = @config_hash.config['ira_to_non_ira_xfer']
        interest = @config_hash.config['savings_interest_rate'] / 100.0

        this_year.upto(final_year) do |year|
            if year.is_age < 60
                non_ira_account_value = ((non_ira_account_value +
                                sav_spend(year)) * (1 + interest)).round
            else
                non_ira_account_value = ((non_ira_account_value +
                                sav_spend(year) + ira_to_non_ira_xfer) *
                                (1 + interest)).round
            end
        end  # do
    return non_ira_account_value
    end
end
