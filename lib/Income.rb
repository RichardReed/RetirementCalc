# Calculate income for a specific year
# Improving income starts with working 9 months (hourly pay * 1500)
# Improving income after 'six_mo_work_start_age' is (hourly pay * 1000)

require_relative 'Config'
require_relative 'AgeYear'

class IncomeCalc

  def initialize
    @config_hash = ConfigFile.new
  end

  def navy_ret_start_year
    @config_hash.config['starting_year']
  end

  def navy_ret_income(final_year)
    nonworking_income(final_year, 'starting_navy_ret', 
             navy_ret_start_year, 'navy_and_ss_raise')
  end

  def ge_pension_start_year
    @config_hash.config['starting_year']
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
    if final_year >= @config_hash.config['ss_reduction_year']
      ss_income = (ss_income *
             @config_hash.config['ss_reduction_percent'].to_f / 100).round
    end
    return ss_income
  end

  def ss_spouse_start_year
    @config_hash.config['ss_spouse_start_age'].is_year
  end

  def ss_spouse_income(final_year)
    ss_spouse_income = nonworking_income(final_year,
        'starting_spouse_ss',ss_spouse_start_year, 'navy_and_ss_raise')
    if final_year >= @config_hash .config['ss_reduction_year']
         ss_spouse_income = (ss_spouse_income *
         @config_hash.config['ss_reduction_percent'].to_f / 100.0).round
    end
    return ss_spouse_income
  end
       
  def gross_income(final_year)
    pension_income(final_year) + lump_sum_income(final_year) *
               partial_starting_year(final_year)
  end

  def lump_sum_income(final_year)
    if @config_hash.config[final_year.to_s].to_i > 0
      lump_sum_income = (@config_hash.config[final_year.to_s].to_i)
    else
      lump_sum_income = 0
    end
  end

  def pension_income(final_year)
    (navy_ret_income(final_year) + ge_pension_income(final_year) +
        alc_pension_income(final_year) + ss_income(final_year) +
        ss_spouse_income(final_year)) * partial_starting_year(final_year)
  end

private

  def nonworking_income(final_year, starting_income, starting_year, raise)
    income = @config_hash.config[starting_income] * 12

    return 0 if final_year < starting_year

    (starting_year + 1).upto(final_year) do
      income = (income * (1 + @config_hash.config[raise] / 100.0)).round
    end
    return income
  end

  def partial_starting_year(final_year)
    if final_year == @config_hash.config['starting_year']
      (13 - @config_hash.config['starting_month']) / 12.to_f
    else
      1
    end
  end
end
