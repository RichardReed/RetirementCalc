# Runs the retirement calculator to determine the year in which retirement
#     money runs out.
# Stops at age 120 if money has not run out.

require_relative 'Config'
require_relative 'Results'
require_relative 'AgeYear'
require_relative 'IRA'
require_relative 'non-IRA'
require_relative 'ResultsToCommandLine'

class MoneyRanOut
    def initialize
        @config_hash = ConfigFile.instance
        @final_results = Results.new
        @write_results_to_command_line = ResultsToCommandLine.new
        @current_year = @config_hash.config['starting_year']
        @ira_in = IRA.new
        @non_ira_in = NonIRA.new
    end

    def year_ran_out_of_money
        final_year = @current_year
        until (final_year > 120.is_year) ||
                (@ira_in.ira_account(final_year) +
                    @non_ira_in.non_ira_account(final_year) < 0)
            final_year += 1
        end
        return final_year
    end

    def final_year_results
        final_year = year_ran_out_of_money
        @final_results.results_for(final_year)
        @write_results_to_command_line.results_to_command_line
    end
end

@money_ran_out = MoneyRanOut.new
@money_ran_out.final_year_results
