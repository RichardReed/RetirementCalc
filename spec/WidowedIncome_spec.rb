require_relative 'spec_helper'

# Simplifying the widowed income by using the initial value
# of pension incomes to calculate the
# widowed income fraction no matter what year they start in.
# This fraction is then multiplied by the final married pension income to
# obtain the final widowed income.

# puts "config file is: #{@config_file.config}"

describe "calculate initial widowed pension income" do
  context "Use initial widow income values for all pensions." do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
#        "starting_ss" => 3000,
#        "spouse_new_ss" => 1000,
        "widowed" => {
          "starting_navy_ret" => 1000,
          "starting_alc_pension" => 400,
          "starting_ge_pension" => 300
          }
        })
      @config_file.config
      @widowed_income = WidowedIncome.new
    end
    it "returns widowed income of $1,700" do
      expect(@widowed_income.initial_widowed_pension_income).to eq(1700)
    end
  end
  end

describe "calculate initial married pension income" do
  context "Use initial married pension income values." do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
#        "starting_ss" => 3500,
        "married" => {
          "starting_navy_ret" => 1500,
          "starting_alc_pension" => 500,
          "starting_ge_pension" => 400
          }
        })
      @config_file.config
      @widowed_income = WidowedIncome.new
    end
    it "returns married income of $2,400" do
      expect(@widowed_income.initial_married_pension_income).to eq(2400)
    end
  end
end

describe "claculate widowed income fraction" do
  context "with values for initial widowed and initial maried incomes" do
    before (:each) do
      @widowed_income = WidowedIncome.new
      allow(@widowed_income).to receive(:initial_widowed_pension_income)
            .and_return(2000)
      allow(@widowed_income).to receive(:initial_married_pension_income)
            .and_return(4000)
    end
    it "returns widowed income fraction of 0.5" do
      expect(@widowed_income.widowed_pension_income_fract).to eq(0.5)
    end
  end
end
