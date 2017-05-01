# Calculate widowed expenses for the initial year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Expense'

class WidowedExpense

   def initialize
    @config_hash = ConfigFile.new
    @current_year = @config_hash.config['starting_year']
  end

  def initial_widowed_monthly_exp
    @config_hash.config['widowed']['house'] +
    @config_hash.config['widowed']['trailer'] +
    @config_hash.config['widowed']['rv_park'] +
    @config_hash.config['widowed']['recreation'] +
    @config_hash.config['widowed']['non-trailer_vac'] +
    @config_hash.config['widowed']['car'] +
    @config_hash.config['widowed']['groceries'] +
    @config_hash.config['widowed']['restaurant'] +
    @config_hash.config['widowed']['insurance'] +
    @config_hash.config['widowed']['pres_donate'] +
    @config_hash.config['widowed']['rick_vicky'] +
    @config_hash.config['widowed']['pets'] +
    @config_hash.config['widowed']['medical']
   end
 
   def initial_widowed_annual_exp
     (initial_widowed_monthly_exp * 12) +
    @config_hash.config['widowed']['unexpected_exp'] +
    @config_hash.config['widowed']['property_tax'] +
    @config_hash.config['widowed']['property_insurance'] +
    @config_hash.config['widowed']['country_place_dues']
   end

  def widowed_expense_fract
    initial_widowed_expense/initial_married_expense.to_f
  end
end
