# Calclate age from year and year from age
# Added "married" as marital status for testing.

require_relative 'Config'

class Integer

    def is_age
        self - $CONFIG['birth_year']
    end

    def is_year
        self + $CONFIG['birth_year']
    end
end
