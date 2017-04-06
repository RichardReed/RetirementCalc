require_relative 'spec_helper'
 
# Simplifying the widowed expenses by using the initial value 
# of all expenses to calculate the 
# widowed expense fraction no matter what year they start in.
# This fraction is then multiplied by the final married expense to 
# obtain the final widowed expense.
#puts "config file is: #{@config_file.config}"

describe "calculate initial annual widowed expenses" do
  context "Use initial widow expense values.  " do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_ss" => 3000,
        "spouse_new_ss" => 1000,
        "widowed" => {
          "starting_navy_ret" => 1000,
          "starting_alc_pension" => 400,
          "starting_ge_pension" => 300
          }
        })
      @widowed_income = WidowedIncome.new
    end
    it "returns widowed income of $5,700" do
      expect(@widowed_income.initial_widowed_income).to eq(5700)
    end
  end
end
=begin
describe "calculate initial married income" do
  context "Use initial married income values for all but SS.  " +
    "For SS use the sum of the starting_ss and spouse_new_ss" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_ss" => 3500,
        "married" => {
          "starting_navy_ret" => 1500,
          "starting_alc_pension" => 500,
          "starting_ge_pension" => 400
          }
        })
      @widowed_income = WidowedIncome.new
    end
    it "returns married income of $5,900" do
      expect(@widowed_income.initial_married_income).to eq(5900)
    end
  end
end

describe "claculate widowed income fraction" do
  context "with values for initial widowed and initial maried incomes" do
    before (:each) do
      @widowed_income = WidowedIncome.new
      allow(@widowed_income).to receive(:initial_widowed_income)
            .and_return(2000)
      allow(@widowed_income).to receive(:initial_married_income)
            .and_return(4000)
    end
    it "returns widowed income fraction of 0.5" do
      expect(@widowed_income.widowed_income_fract).to eq(0.5)
    end
  end
end
=end
