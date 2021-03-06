# Calculate IRA savings and spending.  Calculate amount in IRA account
# No money is taken out of IRA before age 60.
# No money is put into IRA at any time.

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'Expense'

class IRA

  def initialize
    @current_year = $CONFIG['starting_year']
    @income_in = IncomeCalc.new
    @expenses_in = ExpenseCalc.new
  end

  def ira_spend(ret_year)
    return 0 if ret_year < 60.is_year
    ira_spend = @income_in.gross_income(ret_year) -
                @expenses_in.gross_exp(ret_year)
    return 0 if ira_spend > 0
  return ira_spend
  end

  def ira_account(final_year)
    this_year = @current_year
    starting_ira_value = $CONFIG['starting_ira']
    starting_ira_disc = $CONFIG['starting_savings_discount']
    ira_to_non_ira_xfer = $CONFIG['ira_to_non_ira_xfer']
    interest = $CONFIG['savings_interest_rate'] / 100.0

    ira_account_value = starting_ira_value * starting_ira_disc / 100

    this_year.upto(final_year) do |year|
      if year.is_age < 60
        ira_account_value = ((ira_account_value + ira_spend(year)) *
                            (1 + interest)).round
      else
        ira_account_value = ((ira_account_value + ira_spend(year) -
                         ira_to_non_ira_xfer) * (1 + interest)).round
      end
    end  # do
    return ira_account_value
  end
end
