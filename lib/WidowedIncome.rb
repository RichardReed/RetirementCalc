# Calculate widowed income for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'

class WidowedIncome

  def initialize
    @config_hash = ConfigFile.new
  end

  def initial_widowed_pension_income
    @config_hash.config['widowed']['starting_navy_ret'] +
    @config_hash.config['widowed']['starting_alc_pension'] +
    @config_hash.config['widowed']['starting_ge_pension'] 
  end

  def initial_married_pension_income
    @config_hash.config['married']['starting_navy_ret'] +
    @config_hash.config['married']['starting_alc_pension'] +
    @config_hash.config['married']['starting_ge_pension'] 
  end
  
  def widowed_pension_income_fract
    initial_widowed_pension_income/initial_married_pension_income.to_f
  end
end
