#Calculate income for a specific year
#Improving income starts with working 9 months (hourly pay * 1500)
#Improving income after 'six_mo_work_start_age' is (hourly pay * 1000) 

require_relative 'Config'
require_relative 'AgeYear'


class IncomeCalc

	def initialize
	@config_hash = ConfigFile.instance
	end
	
	def last_improving_year
		@config_hash.config['last_yr_improv_work_age'].is_year
	end
	
	def improving_income(final_year)
    year_start_working_6_mo = @config_hash.config['six_mo_improv_start_age'].is_year
		improving_9_mo_income = @config_hash.config['start_improv_hourly_pay'] * 1500
    improving_6_mo_income = @config_hash.config['start_improv_hourly_pay'] * 1000
		
		if final_year > last_improving_year then return 0 
    elsif final_year >= year_start_working_6_mo then return improving_6_mo_income 
    else return improving_9_mo_income
    end
	end
	

	def navy_ret_start_year
		@config_hash.config['navy_ret_start_age'].is_year
	end
		
	def navy_ret_income(final_year)
		nonworking_income(final_year, 'starting_navy_ret', navy_ret_start_year, 'navy_and_ss_raise')
	end
	
	def ge_pension_start_year
		@config_hash.config['ge_pension_start_age'].is_year
	end

	def ge_pension_income(final_year)
		nonworking_income(final_year, 'starting_ge_pension', ge_pension_start_year, 'ge_pension_raise')
	end
	
	def alc_pension_start_year
		@config_hash.config['alc_pension_start_age'].is_year
	end

	def alc_pension_income(final_year)
		nonworking_income(final_year, 'starting_alc_pension', alc_pension_start_year, 'alc_pension_raise')
	end
	
	def ss_start_year
		@config_hash.config['ss_start_age'].is_year
	end

	def ss_income(final_year)
		nonworking_income(final_year, 'starting_ss', ss_start_year, 'navy_and_ss_raise')
	end
  
   def lump_sum_income(final_year)  
    if @config_hash.config[final_year.to_s].to_i > 0
      lump_sum_income = (@config_hash.config[final_year.to_s].to_i)  
    else
      lump_sum_income = 0
    end
  end
	
	def gross_income(final_year)
		improving_income(final_year) + navy_ret_income(final_year) +
		ge_pension_income(final_year) + alc_pension_income(final_year) + 
    ss_income(final_year) + lump_sum_income(final_year)
	end
	
	def pension_income(final_year)
		navy_ret_income(final_year) + ge_pension_income(final_year) +
		alc_pension_income(final_year) + ss_income(final_year)
	end

private  
  def nonworking_income (final_year, starting_income, starting_year, raise)
    income = @config_hash.config[starting_income] * 12
	
		return 0 if final_year < starting_year

		(starting_year + 1).upto(final_year) do 
					income = (income * (1 + @config_hash.config[raise]/100.0)).round
		end
		return income
	end

end