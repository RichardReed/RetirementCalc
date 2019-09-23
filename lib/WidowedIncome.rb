# Calculate widowed income for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'Income'

class WidowedIncome

  def initialize
  end

  def initial_widowed_pension_income
    $CONFIG['widowed']['starting_navy_ret'] +
    $CONFIG['widowed']['starting_alc_pension'] +
    $CONFIG['widowed']['starting_ge_pension']
  end

  def initial_married_pension_income
    $CONFIG['married']['starting_navy_ret'] +
    $CONFIG['married']['starting_alc_pension'] +
    $CONFIG['married']['starting_ge_pension']
  end

  def widowed_pension_income_fract
    initial_widowed_pension_income/initial_married_pension_income.to_f
  end
end
