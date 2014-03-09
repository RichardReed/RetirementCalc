# Calclate age from year and year from age

require_relative 'Config'

class Fixnum

    def is_age
        self - ConfigFile.instance.config['birth_year']
    end

    def is_year
        self + ConfigFile.instance.config['birth_year']
    end
end
