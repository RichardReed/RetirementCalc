# Calculate expenses for a specific year

require_relative 'Config'
require_relative 'AgeYear'

class ExpenseCalc

    def initialize
        @config_hash = ConfigFile.instance
        @current_year = @config_hash.config['starting_year']
    end

    def starting_monthly_exp
        @config_hash.config['home_util'] + @config_hash.config['rick_vicky'] +
        @config_hash.config['groc_house'] + @config_hash.config['insurance'] +
        @config_hash.config['pres_donat'] + @config_hash.config['car'] +
        @config_hash.config['home_upkeep'] + @config_hash.config['pets'] +
        @config_hash.config['restaurant'] + @config_hash.config['travel']
    end

    def starting_annual_exp
        (starting_monthly_exp * 12) + @config_hash.config['large_annual_exp']
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
            annual_exp -= (reduce_property_tax(year) +
                house_payment_end(year))
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
        annual_med_exp += med_exp_increase(year)
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

    def house_payment_end(year)
        if year == @config_hash.config['house_payment_end_year']
            (@config_hash.config['mo_house_payment_reduction'] * 12)
        else
            0
        end
    end

    def med_exp_increase(year)
        if year == @config_hash.config['navy_ret_start_age'].is_year
            (@config_hash.config['mo_med_exp_increase'] * 12)
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