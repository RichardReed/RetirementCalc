# Runs the retirement calculator for a specific year

require_relative 'Results'

print 'Please enter the age or year for your retirement financial status:  '
age_year = gets.to_i
@final_results = Results.new
@final_results.results_for(age_year)

File.open('results.yml', 'r') do |file|
    while line = file.gets
        puts line
    end
end