# Runs the retirement calculator for the specified year
# creates the $config global hash file
# and puts the results in the results.yml file.

require_relative 'Results'

print 'Please enter the age or year for your retirement financial status:  '
age_year = gets.to_i
@config_hasn = ConfigFile.new  #just added
$config = @config_hash.config
puts $config #just added
@final_results = Results.new
@final_results.results_for(age_year)

File.open('results.yml', 'r') do |file|
    while line = file.gets
        puts line
    end
end
