# Calclate age from year and year from age

require_relative 'Config'

class Fixnum

    def is_age
        config_file = ConfigFile.new
        self - config_file.config["birth_year"]
    end

    def is_year
        config_file = ConfigFile.new
        self + config_file.config["birth_year"]
    end
end
