# Calculate income and SS taxes on Income

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'IRA'
require_relative 'non-IRA'

class IncomeTax

  def initialize
    @income_in = IncomeCalc.new
    @ira_spending = IRA.new
  end

  def income_tax(year)
    payrole_tax(year)
  end

  def taxable_income(year)
    income(year)
  end

private

  def payrole_tax(year)
    income = income(year)

#  Removing error raising for now.
#         raise RangeError if @ira_spending.ira_spend(year) > 0

#        if @ira_spending.ira_spend(year) > 0
#            return "Error: IRA is #{@ira_spending.ira_spend(year)}.
#                It should not be positive"
#        end

    case income
    when 0..$CONFIG['bottom_bracket_min']
         0
    when ($CONFIG['bottom_bracket_min'] + 1)..\
          $CONFIG['middle_bracket_min']
         (0.1 * (income - $CONFIG['bottom_bracket_min'])).\
             round
    when ($CONFIG['middle_bracket_min'] + 1)..\
          $CONFIG['upper_bracket_min']
         ($CONFIG['middle_bracket_base_tax'] + 0.15 *\
           (income - $CONFIG['middle_bracket_min'])).round
    else
        ($CONFIG['upper_bracket_base_tax'] + 0.25 *\
           (income - $CONFIG['upper_bracket_min'])).round
    end
  end

  def income(year)
    if year.is_age < 60
      income_calc(year)
    else
      income_calc(year) + $CONFIG['ira_to_non_ira_xfer']
    end
  end

  def income_calc(year)
    @income_in.gross_income(year) - @ira_spending.ira_spend(year) -\
      @income_in.life_insurance_income(year)
    # Note:  IRA spending is a negative number
  end
end
