#Runs the retirement calculator to determine the year in which retirement money runs out.
#Stops at age 120 if money has not run out.

require_relative 'Config'
require_relative 'Results'
require_relative 'AgeYear'
require_relative 'IRA'
require_relative 'non-IRA'
require_relative 'ResultsToCommandLine'

class LastYearWithMoney
	def initialize
		@config_hash = ConfigFile.instance
		@final_results = Results.new
		@write_results_to_command_line = ResultsToCommandLine.new
		@current_year = @config_hash.config['starting_year']
		@ira_in = IRA.new
		@non_ira_in = NonIRA.new
	end

	def year_last_with_money
		final_year = @current_year
		until (final_year > 120.is_year) ||
				(@ira_in.ira_account(final_year) + @non_ira_in.non_ira_account(final_year) < 0)
			final_year += 1
		end
		@final_results.results_for(final_year - 1)
		@write_results_to_command_line.results_to_command_line()
		#File.open('results.yml', 'r') do |file|  
		#	while line = file.gets  
		#		puts line  
		#	end  
		#end  
	end
end

@last_year_with_money = LastYearWithMoney.new
@last_year_with_money.year_last_with_money

=begin
File.open('results.yml', 'r') do |file|  
	while line = file.gets  
		puts line  
	end  
end 
=end 