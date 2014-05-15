# Gives the retirement status for a specific year or age.

require_relative 'Results'

    def print_results_file_to_console
        File.open('Results.yml', 'r') do |file|
            while line = file.gets
                puts line
            end
        end
    end

print 'Please enter the year or age for retirement finances:  '
final_age_year = gets.to_i
@final_results = Results.new
@final_results.results_for(final_age_year)
print_results_file_to_console
