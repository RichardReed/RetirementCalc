# Calculate widowed expenses for the initial year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Expense'

class WidowedExpense

   def initialize
    @current_year = $CONFIG['starting_year']
  end

  def initial_widowed_monthly_exp
    $CONFIG['widowed']['house'] +
    $CONFIG['widowed']['trailer'] +
    $CONFIG['widowed']['rv_park'] +
    $CONFIG['widowed']['recreation'] +
    $CONFIG['widowed']['non-trailer_vac'] +
    $CONFIG['widowed']['car'] +
    $CONFIG['widowed']['groceries'] +
    $CONFIG['widowed']['restaurant'] +
    $CONFIG['widowed']['insurance'] +
    $CONFIG['widowed']['pres_donate'] +
    $CONFIG['widowed']['rick_vicky'] +
    $CONFIG['widowed']['pets'] +
    $CONFIG['widowed']['medical']
   end

   def initial_widowed_annual_exp
     (initial_widowed_monthly_exp * 12) +
    $CONFIG['widowed']['unexpected_exp'] +
    $CONFIG['widowed']['property_tax'] +
    $CONFIG['widowed']['property_insurance'] +
    $CONFIG['widowed']['country_place_dues']
   end
end
