require_relative 'spec_helper'

describe "income_tax (this_year)" do
  describe "calculates the income tax for amount of income" do
    context "with tax bracket minimums of $10,001, $20,001 and 30,001"\
            " and base tax of $0, $2k and $5k" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "bottom_bracket_min" => 10000,
          "middle_bracket_min" => 20000,
          "upper_bracket_min" => 30000,
          "middle_bracket_base_tax" => 2000,
          "upper_bracket_base_tax" => 5000,
          })
        @config_file.config
        @taxes = IncomeTax.new
        allow(@taxes).to receive(:income).and_return(1)
      end
      it "returns $0 with $0 income" do
        expect(@taxes.income_tax(2020)).to eq(0)
      end
      it "returns $0 with $10,000 income" do
        allow(@taxes).to receive(:income).and_return(10000)
        expect(@taxes.income_tax(2020)).to eq(0)
      end
      it "returns $1 with $10,005 income" do
        allow(@taxes).to receive(:income).and_return(10005)
        expect(@taxes.income_tax(2020)).to eq(1)
      end
      it "returns $1000 with $20,000 income" do
        allow(@taxes).to receive(:income).and_return(20000)
        expect(@taxes.income_tax(2020)).to eq(1000)
      end
      it "returns $2000 with $20,001 income" do
        allow(@taxes).to receive(:income).and_return(20001)
        expect(@taxes.income_tax(2020)).to eq(2000)
      end
      it "returns $2001 with $20,004 income" do
        allow(@taxes).to receive(:income).and_return(20004)
        expect(@taxes.income_tax(2020)).to eq(2001)
      end
      it "returns $3500 with $30,000 income" do
        allow(@taxes).to receive(:income).and_return(30000)
        expect(@taxes.income_tax(2020)).to eq(3500)
      end
      it "returns $5000 with $30,001 income" do
        allow(@taxes).to receive(:income).and_return(30001)
        expect(@taxes.income_tax(2020)).to eq(5000)
      end
      it "returns $5001 with $30,003 income" do
        allow(@taxes).to receive(:income).and_return(30003)
        expect(@taxes.income_tax(2020)).to eq(5001)
      end
    end
  end
end

describe "taxable_income (this_year)" do
  describe "calculates the income for this_year" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_year" => 2010,
        "birth_year" => 1960,
        "ira_to_non_ira_xfer" => 10000,
        })
      @config_file.config
      @taxes = IncomeTax.new
      allow_any_instance_of(IncomeCalc).to receive_messages(
                :life_insurance_income => 20000, :gross_income => 50000)
      allow_any_instance_of(IRA).to receive(:ira_spend).and_return(-5000)
    end
    context "with age of 60 (gross_income + IRA to non-IRA xfer"\
            " + IRA_spending - tax free life_insurance_income)" do
      it "returns $45,000 income" do
        expect(@taxes.taxable_income(2020)).to eq(45000)
      end
    end
    context "with age of 59 (gross_income + IRA_spending"\
            " - tax free life_insurance_income)" do
      it "returns $35,000 income" do
        expect(@taxes.taxable_income(2019)).to eq(35000)
      end
    end
  end
end

=begin
Removing error raising from IncomeTax.rb for now.
describe "income_tax (this year)" do
  describe "calculates the year's income taxes" do
    context "with a positive spending of $1" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2010,
          "birth_year" => 1960,
          })
        @config_file.config
        allow_any_instance_of(IRA).to receive(:ira_spend).
                 and_return(1)
        @tax = IncomeTax.new
        allow(@tax).to receive(:income).and_return(0)
      end
      it "returns an error since spending is positive" do
        allow_any_instance_of(IRA).to receive(:ira_spend).
                 and_return(0)
        expect(@tax.income_tax(2020)).to raise_error
   #              ("Error: IRA is 1. It should not be positive")
      end
    end
  end
end
=end
