# Calculate expenses for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'WidowedExpense'

class ExpenseCalc

  def initialize
    @widowed_expense = WidowedExpense.new
    @current_year = $CONFIG['starting_year']
  end

  def initial_monthly_exp
    $CONFIG['married']['house'] +
    $CONFIG['married']['trailer'] +
    $CONFIG['married']['rv_park'] +
    $CONFIG['married']['recreation'] +
    $CONFIG['married']['non-trailer_vac'] +
    $CONFIG['married']['car'] +
    $CONFIG['married']['groceries'] +
    $CONFIG['married']['restaurant'] +
    $CONFIG['married']['insurance'] +
    $CONFIG['married']['pres_donate'] +
    $CONFIG['married']['rick_vicky'] +
    $CONFIG['married']['pets']
  end

  def initial_annual_exp
    (initial_monthly_exp * 12) +
    $CONFIG['married']['unexpected_exp'] +
    $CONFIG['married']['property_tax'] +
    $CONFIG['married']['property_insurance'] +
    $CONFIG['married']['country_place_dues']
  end

  def initial_annual_med_exp
    $CONFIG['married']['medical'] * 12
  end

  def annual_exp(final_year)
    this_year = @current_year + 1
    annual_exp = initial_annual_exp * partial_starting_year(final_year)
    this_year.upto(final_year) do |year|
      annual_exp = (annual_exp * (1 +
                $CONFIG['expense_inflation'] / 100.0)).round
      annual_exp -= (reduce_property_tax(year))
    end # do
      return annual_exp
  end

  def large_exp(final_year)   #Expenses are negative
    if final_year >= $CONFIG['widowed']['widowed_year'] &&
         $CONFIG['widowed'][final_year.to_s].to_i < 0
      large_exp = -($CONFIG['widowed'][final_year.to_s].to_i)
    elsif
      final_year < $CONFIG['widowed']['widowed_year'] &&
            $CONFIG['married'][final_year.to_s].to_i < 0
      large_exp = -($CONFIG['married'][final_year.to_s].to_i)
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
                   $CONFIG['med_exp_inflation'] / 100.0)).round
    end # do
    return annual_med_exp
  end

  def gross_exp(final_year)
    if final_year >= $CONFIG['widowed']['widowed_year']
      return ((annual_exp(final_year) + annual_med_exp(final_year)) *
             widowed_expense_fract + large_exp(final_year)).round
    else
      return annual_exp(final_year) + annual_med_exp(final_year) +
             large_exp(final_year)
    end
  end

def widowed_expense_fract
  @widowed_expense.initial_widowed_annual_exp/
        (initial_annual_exp + initial_annual_med_exp).to_f
end


private

  def reduce_property_tax(year)
    if year == $CONFIG['reduce_prop_tax_age'].is_year
      $CONFIG['property_tax_reduction']
    else
      0
    end
  end

  def partial_starting_year(final_year)
    if final_year == $CONFIG['starting_year']
      (13 - $CONFIG['starting_month']) / 12.to_f
    else
      1
    end
  end
end
