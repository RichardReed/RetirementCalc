# Calculate widowed expenses for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Expense'

class WidowedExpense
=begin
  def initialize
    @config_hash = ConfigFile.new
  end

  def initial_widowed_income
    @config_hash.config['starting_ss'] +
    @config_hash.config['spouse_new_ss'] +
    @config_hash.config['widowed']['starting_navy_ret'] +
    @config_hash.config['widowed']['starting_alc_pension'] +
    @config_hash.config['widowed']['starting_ge_pension'] 
  end

  def initial_married_income
    @config_hash.config['starting_ss'] +
    @config_hash.config['married']['starting_navy_ret'] +
    @config_hash.config['married']['starting_alc_pension'] +
    @config_hash.config['married']['starting_ge_pension'] 
  end
  
  def widowed_income_fract
    initial_widowed_income/initial_married_income.to_f
  end
=end
end
