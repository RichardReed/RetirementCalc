# Takes results from Results.yml file and writes them to the command line

class ResultsToCommandLine

    def results_to_command_line
        File.open('results.yml', 'r') do |file|
            while line = file.gets
                puts line
            end
        end
    end
end


