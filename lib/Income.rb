# Calculate income for a specific year

require_relative 'Config'
require_relative 'AgeYear'
require_relative 'WidowedIncome'

class IncomeCalc

  def initialize
    @config_hash = ConfigFile.new
    @widowed_income = WidowedIncome.new
  end

  def navy_ret_start_year
    @config_hash.config['navy_ret_start_age'].is_year
  end

  def navy_ret_income(final_year)
    nonworking_income(final_year, 'starting_navy_ret', 
             navy_ret_start_year, 'navy_and_ss_raise')
  end

  def ge_pension_start_year
    @config_hash.config['ge_pension_start_age'].is_year
  end

  def ge_pension_income(final_year)
    nonworking_income(final_year, 'starting_ge_pension',
              ge_pension_start_year, 'ge_pension_raise')
  end

  def alc_pension_start_year
    @config_hash.config['alc_pension_start_age'].is_year
  end

  def alc_pension_income(final_year)
    nonworking_income(final_year, 'starting_alc_pension',
             alc_pension_start_year, 'alc_pension_raise')
  end

  def ss_start_year
    @config_hash.config['ss_start_age'].is_year
  end

  def ss_income(final_year)
    ss_income = nonworking_income(final_year, 'starting_ss', ss_start_year,
                'navy_and_ss_raise')
    reduced_ss_income(final_year, ss_income)
  end

  def spouse_ss_start_year
    @config_hash.config['spouse_ss_age'].is_year
  end

  def new_spouse_ss_start_year
    @config_hash.config['spouse_new_ss_age'].is_year
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
    if final_year < @config_hash.config['widowed']['widowed_year'] 
      marital_status = 'married'
    else
      marital_status = 'widowed'
    end
    if @config_hash.config[marital_status][final_year.to_s].to_i > 0
      lump_sum_income = (@config_hash.config[marital_status][final_year.to_s].to_i)
    else
      lump_sum_income = 0
    end
  end

  def life_insurance_income(final_year)
    if final_year == @config_hash.config['widowed']['widowed_year'] 
      life_insurance_income = (@config_hash.config['widowed']['life_insurance'].to_i)
    else
      life_insurance_income = 0
    end
  end

  def total_pension_income(final_year)
    pension_income = (navy_ret_income(final_year) + 
                      ge_pension_income(final_year) +
                      alc_pension_income(final_year) + 
                      ss_income(final_year) +
                      ss_spouse_income(final_year)) * 
                      partial_starting_year(final_year)
    if final_year >= @config_hash.config['widowed']['widowed_year'] 
      return (pension_income * @widowed_income.widowed_income_fract)
    else
      return pension_income
    end
  end

private

  def nonworking_income(final_year, starting_income, starting_year, raise)
    if @config_hash.config.has_key?(starting_income)
      income = @config_hash.config[starting_income] * 12 
    else
      income =  @config_hash.config["married"][starting_income] * 12
    end

    return 0 if final_year < starting_year

    (starting_year + 1).upto(final_year) do
      income = (income * (1 + @config_hash.config[raise] / 100.0)).round
    end
    return income
  end

  def reduced_ss_income(final_year, ss_income)
    if final_year >= @config_hash.config['ss_reduction_year']
      return (ss_income *
           @config_hash.config['ss_reduction_percent'].to_f / 100.0).round
    else
      return ss_income
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
