#Calculate income and SS taxes on Income 

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
        payrole_tax(year) + ss_tax(year) 
    end
  
private
    def payrole_tax(year)
        ira_to_non_ira_xfer = @config_hash.config['ira_to_non_ira_xfer']
		gross_income = @income_in.gross_income(year)

        if year.is_age < 60
            income = gross_income - @income_in.lump_sum_income(year) - @ira_spending.ira_spend(year)
        else
             income = gross_income - @income_in.lump_sum_income(year) - @ira_spending.ira_spend(year) + ira_to_non_ira_xfer  
	        # Note:  IRA spending is a negative number
        end
    
        if @ira_spending.ira_spend(year) > 0
            return "Error: IRA is #{@ira_spending.ira_spend(year)}.  It should not be positive" 
        elsif income < 19000
            0
        elsif income < 36000
            (0.1 * (income - 19000)).round
        elsif income < 88000
            (1700 + 0.15 * (income - 36000)).round
        else
            (9500 + 0.25 * (income - 88000)).round
        end
    end
  
    def ss_tax(year)
        (@income_in.improving_income(year) * 0.0765).round
    end
end