require_relative 'spec_helper'

describe "ira_spend" do
  describe "calculates the change in IRA savings for the year" do
    context "with expenses exceeding income by $1000" do
      before (:each) do
        config_file = ConfigFile.new
        config_file.set_config_override ({ "birth_year" => 1960 })
        config_file.config
        @ira = IRA.new
        allow_any_instance_of(IncomeCalc).to receive(:gross_income).
                 and_return(1000)
        allow_any_instance_of(ExpenseCalc).to receive(:gross_exp).
                 and_return(2000)
      end
      it "returns $0 if age is less than 60" do
        expect(@ira.ira_spend(2019)).to eq(0)
      end
      it "returns -$1000 if age is 60 or greater" do
        expect(@ira.ira_spend(2020)).to eq(-1000)
      end
    end
    context "with income exceeding expenses by $1" do
      it "returns $0" do
        config_file = ConfigFile.new
        config_file.set_config_override ({ "birth_year" => 1960 })
        config_file.config
        @ira = IRA.new
        allow_any_instance_of(IncomeCalc).to receive(:gross_income).
                 and_return(2000)
        allow_any_instance_of(ExpenseCalc).to receive(:gross_exp).
                 and_return(1999)
        expect(@ira.ira_spend(2030)).to eq(0)
      end
    end
  end
end
describe "ira_account" do
  describe "calculates the IRA account value in the final year. "+
            "(does not allow transfer of money from IRA savings "+
            "if age is less than 60)"  do
    context "with initial age 60 and IRA value of $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2020,
          "birth_year" => 1960,
          "starting_ira" => 1000,
          "starting_savings_discount" => 100,
          "ira_to_non_ira_xfer" => 0,
          "savings_interest_rate" => 0
          })
        @config_file.config
        @ira = IRA.new
        allow(@ira).to receive(:ira_spend).and_return(0)
      end
      it "returns $1000 the first year with $0 spending" do
        expect(@ira.ira_account(2020)).to eq(1000)
      end
      it "returns $1000 the sixth` year with $0 spending" do
        expect(@ira.ira_account(2025)).to eq(1000)
      end
      it "returns $900 the first year with $100 annual spending" do
        allow(@ira).to receive(:ira_spend).and_return(-100)
        expect(@ira.ira_account(2020)).to eq(900)
      end
      it "returns $500 the fifth year with $100 annual spending" do
        allow(@ira).to receive(:ira_spend).and_return(-100)
        expect(@ira.ira_account(2024)).to eq(500)
      end
      it "returns $900 the first year with $100 transfered from IRA" do
        @config_file.config["ira_to_non_ira_xfer"] = 100
        expect(@ira.ira_account(2020)).to eq(900)
      end
      it "returns $-100 the eleventh year with $100 transfered from IRA" do
        @config_file.config["ira_to_non_ira_xfer"] = 100
        expect(@ira.ira_account(2030)).to eq(-100)
      end
      it "returns $1100 the first year with 10% interest rate" do
        @config_file.config["savings_interest_rate"] = 10
        expect(@ira.ira_account(2020)).to eq(1100)
      end
      it "returns $1610 the fifth year with 10% interest rate" do
        @config_file.config["savings_interest_rate"] = 10
        expect(@ira.ira_account(2024)).to eq(1610)
      end
    end
    context "with initial age 50 and IRA value of $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2020,
          "birth_year" => 1970,
          "starting_ira" => 1000,
          "starting_savings_discount" => 100,
          "ira_to_non_ira_xfer" => 0,
          "savings_interest_rate" => 0
          })
        @config_file.config
        @ira = IRA.new
        allow(@ira).to receive(:ira_spend).and_return(0)
      end
      it "returns $1000 the first year with $0 spending" do
        expect(@ira.ira_account(2020)).to eq(1000)
      end
      it "returns $1000 the sixth year with $0 spending" do
        expect(@ira.ira_account(2025)).to eq(1000)
      end
      it "returns $900 the first year with $100 annual spending" do
        allow(@ira).to receive(:ira_spend).and_return(-100)
        expect(@ira.ira_account(2020)).to eq(900)
      end
      it "returns $500 the fifth year with $100 annual spending" do
        allow(@ira).to receive(:ira_spend).and_return(-100)
        expect(@ira.ira_account(2024)).to eq(500)
      end
      it "returns $1000 the fifth year although $100 transfered from IRA" do
        @config_file.config["ira_to_non_ira_xfer"] = 100
        expect(@ira.ira_account(2024)).to eq(1000)
      end
      it "returns $500 the 15th year with $100 transfered from IRA" do
        @config_file.config["ira_to_non_ira_xfer"] = 100
        expect(@ira.ira_account(2034)).to eq(500)
      end
      it "returns $1100 the first year with 10% interest rate" do
        @config_file.config["savings_interest_rate"] = 10
        expect(@ira.ira_account(2020)).to eq(1100)
      end
      it "returns $1610 the fifth year with 10% interest rate" do
        @config_file.config["savings_interest_rate"] = 10
        expect(@ira.ira_account(2024)).to eq(1610)
      end
    end
  end
end
