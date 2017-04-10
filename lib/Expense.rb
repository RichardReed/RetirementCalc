# Calculate expenses for a specific year

require_relative 'Config'
require_relative 'AgeYear'

class ExpenseCalc

  def initialize
    @config_hash = ConfigFile.new
    @current_year = @config_hash.config['starting_year']
  end

  def starting_monthly_exp
    @config_hash.config['house_exp'] + 
    @config_hash.config['trailer_exp'] + 
    @config_hash.config['rv_park'] + 
    @config_hash.config['rec_exp'] + 
    @config_hash.config['non-trailer_vac'] +
    @config_hash.config['car'] + 
    @config_hash.config['groceries'] + 
    @config_hash.config['restaurant'] + 
    @config_hash.config['insurance'] + 
    @config_hash.config['pres_donate'] + 
    @config_hash.config['rick_vicky'] +
    @config_hash.config['pets'] 
  end
    
  def starting_annual_exp
    (starting_monthly_exp * 12) + 
    @config_hash.config['large_annual_exp'] + 
    @config_hash.config['property_tax'] +
    @config_hash.config['property_insurance'] +
    @config_hash.config['country_place_dues']
  end

  def starting_annual_med_exp
    @config_hash.config['medical'] * 12
  end

  def annual_exp(final_year)
    this_year = @current_year + 1
    annual_exp = starting_annual_exp * partial_starting_year(final_year)
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
    annual_med_exp = starting_annual_med_exp *
                     partial_starting_year(final_year)
    this_year.upto(final_year) do |year|
      annual_med_exp = (annual_med_exp * (1 +
                   @config_hash.config['med_exp_inflation'] / 100.0)).round
    end # do
    return annual_med_exp
  end

  def gross_exp(final_year)
    annual_exp(final_year) + annual_med_exp(final_year) +
                    large_exp(final_year)
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
