# Calculate income for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'WidowedIncome'

class IncomeCalc

  def initialize
    @widowed_income = WidowedIncome.new
  end

  def navy_ret_start_year
    $CONFIG['navy_ret_start_age'].is_year
  end

  def navy_ret_income(final_year)
    nonworking_income(final_year, 'starting_navy_ret',
             navy_ret_start_year, 'navy_and_ss_raise')
  end

  def ge_pension_start_year
    $CONFIG['ge_pension_start_age'].is_year
  end

  def ge_pension_income(final_year)
    nonworking_income(final_year, 'starting_ge_pension',
              ge_pension_start_year, 'ge_pension_raise')
  end

  def alc_pension_start_year
    $CONFIG['alc_pension_start_age'].is_year
  end

  def alc_pension_income(final_year)
    nonworking_income(final_year, 'starting_alc_pension',
             alc_pension_start_year, 'alc_pension_raise')
  end

  def ss_start_year
    $CONFIG['ss_start_age'].is_year
  end

  def ss_income(final_year)
    ss_income = nonworking_income(final_year, 'starting_ss', ss_start_year,
                'navy_and_ss_raise')
    reduced_ss_income(final_year, ss_income)
  end

  def spouse_ss_start_year
    $CONFIG['spouse_ss_age'].is_year
  end

  def new_spouse_ss_start_year
    $CONFIG['spouse_new_ss_age'].is_year
  end

  def ss_spouse_income(final_year)
    if final_year < new_spouse_ss_start_year
      ss_spouse_income = nonworking_income(final_year,
           'spouse_ss',spouse_ss_start_year, 'navy_and_ss_raise')
      reduced_ss_income(final_year, ss_spouse_income)
    else
      ss_spouse_income = nonworking_income(final_year,
            'spouse_new_ss',new_spouse_ss_start_year, 'navy_and_ss_raise')
      reduced_ss_income(final_year, ss_spouse_income)
    end
  end

  def gross_income(final_year)
    total_pension_income(final_year) + lump_sum_income(final_year) +
           life_insurance_income(final_year)
  end

  def lump_sum_income(final_year)
    if final_year < $CONFIG['widowed']['widowed_year']
      marital_status = 'married'
    else
      marital_status = 'widowed'
    end
    if $CONFIG[marital_status][final_year.to_s].to_i > 0
      lump_sum_income =
        ($CONFIG[marital_status][final_year.to_s].to_i)
    else
      lump_sum_income = 0
    end
  end

  def life_insurance_income(final_year)
    if final_year == $CONFIG['widowed']['widowed_year']
      life_insurance_income =
        ($CONFIG['widowed']['life_insurance'].to_i)
    else
      life_insurance_income = 0
    end
  end

  def total_pension_income(final_year)
    if final_year < $CONFIG['widowed']['widowed_year']
      pension_income = ((navy_ret_income(final_year) +
                      ge_pension_income(final_year) +
                      alc_pension_income(final_year) +
                      ss_income(final_year) +
                      ss_spouse_income(final_year)) *
                      partial_starting_year(final_year)).round
    else
      pension_income = (((navy_ret_income(final_year) +
                      ge_pension_income(final_year) +
                      alc_pension_income(final_year)) *
                      @widowed_income.widowed_pension_income_fract +
                      ss_income(final_year)) *
                      partial_starting_year(final_year)).round
    end
  end

private

  def nonworking_income(final_year, starting_income, starting_year, raise)
    if $CONFIG.has_key?(starting_income)
      income = $CONFIG[starting_income] * 12
    else
      income =  $CONFIG["married"][starting_income] * 12
    end

    return 0 if final_year < starting_year

    (starting_year + 1).upto(final_year) do
      income = (income * (1 + $CONFIG[raise] / 100.0)).round
    end
    return income
  end

  def reduced_ss_income(final_year, ss_income)
    if final_year >= $CONFIG['ss_reduction_year']
      return (ss_income *
           $CONFIG['ss_reduction_percent'].to_f / 100.0).round
    else
      return ss_income
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
