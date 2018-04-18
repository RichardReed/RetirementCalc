# Calclate age from year and year from age
# Added "married" as marital status for testing.

require_relative 'Config'

class Integer

    def is_age
        config_file = ConfigFile.new
        self - config_file.config['birth_year']
    end

    def is_year
        config_file = ConfigFile.new
        self + config_file.config['birth_year']
    end
end
