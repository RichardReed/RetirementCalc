require_relative 'spec_helper'
require_relative '../lib/WidowedExpense'

# Simplifying the widowed expenses by using the initial value
# of all expenses (including Medical and annual expenses) to calculate the
# widowed expense fraction no matter what year they start in.
# This fraction is then multiplied by the final married expense to
# obtain the final widowed expense.

#puts "config file is: #{@config_file.config}"

describe "calculate initial annual widowed expenses" do
  context "Use initial widow expense values.  " do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "widowed" => {
          "house" => 40,
          "trailer" => 90,
          "rv_park" => 140,
          "recreation" => 190,
          "non-trailer_vac" => 240,
          "car" => 290,
          "groceries" => 340,
          "restaurant" => 390,
          "insurance" => 440,
          "invalid_expense" => 100000,
          "pres_donate" => 490,
          "rick_vicky" => 540,
          "pets" => 590,
          "medical" => 900,
          "unexpected_exp" => 500,
          "property_tax" => 100,
          "property_insurance" => 200,
          "country_place_dues" => 300,
          }
        })
      @config_file.config
      @widowed_expense = WidowedExpense.new
    end
    it "returns monthly widowed of $4,680" do
      expect(@widowed_expense.initial_widowed_monthly_exp).to eq(4680)
    end
    it "returns annual widowed of $57,260" do
      expect(@widowed_expense.initial_widowed_annual_exp).to eq(57260)
    end
  end
end
