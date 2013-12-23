# Calculate income and SS taxes on Income

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'
require_relative 'IRA'
require_relative 'non-IRA'

class IncomeTax

    def initialize
        @config_hash = ConfigFile.instance
        @income_in = IncomeCalc.new
        @ira_spending = IRA.new
    end

    def income_tax(year)
        payrole_tax(year)
    end

  private

    def payrole_tax(year)
        income = income(year)

        if @ira_spending.ira_spend(year) > 0
            return "Error: IRA is #{@ira_spending.ira_spend(year)}.
                It should not be positive"
        end

        case income
        when 0..19000
            0
        when 19001..36000
            (0.1 * (income - 19000)).round
        when 36001..88000
            (1700 + 0.15 * (income - 36000)).round
        else
            (9500 + 0.25 * (income - 88000)).round
        end
    end

    def income(year)
        if year.is_age < 60
            income_calc(year)
        else
            income_calc(year) + @config_hash.config['ira_to_non_ira_xfer']
        end
    end

    def income_calc(year)
        @income_in.gross_income(year) - @ira_spending.ira_spend(year)
        # Note:  IRA spending is a negative number
    end
end