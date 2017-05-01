# Calculate expenses for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'WidowedExpense'

class ExpenseCalc

  def initialize
    @config_hash = ConfigFile.new
    @widowed_expense = WidowedExpense.new
    @current_year = @config_hash.config['starting_year']
  end

  def initial_monthly_exp
    @config_hash.config['married']['house'] + 
    @config_hash.config['married']['trailer'] + 
    @config_hash.config['married']['rv_park'] + 
    @config_hash.config['married']['recreation'] + 
    @config_hash.config['married']['non-trailer_vac'] + 
    @config_hash.config['married']['car'] + 
    @config_hash.config['married']['groceries'] + 
    @config_hash.config['married']['restaurant'] + 
    @config_hash.config['married']['insurance'] + 
    @config_hash.config['married']['pres_donate'] +
    @config_hash.config['married']['rick_vicky'] + 
    @config_hash.config['married']['pets']
  end
    
  def initial_annual_exp
    (initial_monthly_exp * 12) + 
    @config_hash.config['married']['unexpected_exp'] + 
    @config_hash.config['married']['property_tax'] +
    @config_hash.config['married']['property_insurance'] +
    @config_hash.config['married']['country_place_dues']
  end

  def initial_annual_med_exp
    @config_hash.config['married']['medical'] * 12
  end

  def annual_exp(final_year)
    this_year = @current_year + 1
    annual_exp = initial_annual_exp * partial_starting_year(final_year)
    this_year.upto(final_year) do |year|
      annual_exp = (annual_exp * (1 +
                @config_hash.config['expense_inflation'] / 100.0)).round
      annual_exp -= (reduce_property_tax(year)) 
    end # do
      return annual_exp
  end

  def large_exp(final_year)
    if @config_hash.config[final_year.to_s].to_i < 0
      large_exp = -(@config_hash.config[final_year.to_s].to_i)
      # Expenses are negative.
    else
      large_exp = 0
    end
  end

  def annual_med_exp(final_year)
    this_year = @current_year + 1
    annual_med_exp = initial_annual_med_exp *
                     partial_starting_year(final_year)
    this_year.upto(final_year) do |year|
      annual_med_exp = (annual_med_exp * (1 +
                   @config_hash.config['med_exp_inflation'] / 100.0)).round
    end # do
    return annual_med_exp
  end

  def gross_exp(final_year)
    if final_year >= @config_hash.config['widowed']['widowed_year']
      return (annual_exp(final_year) + annual_med_exp(final_year)) *
             @widowed_expense.widowed_expense_fract +
             large_exp(final_year)
    else
      return annual_exp(final_year) + annual_med_exp(final_year) +
             large_exp(final_year)
    end
  end

private

  def reduce_property_tax(year)
    if year == @config_hash.config['reduce_prop_tax_age'].is_year
      @config_hash.config['property_tax_reduction']
    else
      0
    end
  end

  def partial_starting_year(final_year)
    if final_year == @config_hash.config['starting_year']
      (13 - @config_hash.config['starting_month']) / 12.to_f
    else
      1
    end
  end
end
