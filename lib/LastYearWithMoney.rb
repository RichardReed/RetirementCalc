# Subtracts one year from results of MoneyRanOut.rb

require_relative 'Results'
require_relative 'ResultsToCommandLine'
require_relative 'MoneyRanOut'

class LastYearWithMoney
    def initialize
        @year_money_ran_out = MoneyRanOut.new
        @final_results = Results.new
        @write_results_to_command_line = ResultsToCommandLine.new
    end

    def year_last_with_money
        final_year = @year_money_ran_out.year_ran_out_of_money - 1
        @final_results.results_for(final_year)
        @write_results_to_command_line.results_to_command_line
    end
end

@last_year_with_money = LastYearWithMoney.new
@last_year_with_money.year_last_with_money
