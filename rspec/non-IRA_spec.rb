require_relative 'spec_helper'

describe "save_spend (this year)" do
  describe "calculates the year's non-IRA savings/spending" do
    context "with income exceeding expenses and taxes by $500" do
      before (:each) do
        config_file = ConfigFile.new
        config_file.set_config_override ({ "birth_year" => 1960 })
        @non_ira = NonIRA.new
        allow_any_instance_of(IncomeCalc).to receive(:gross_income).
                 and_return(2000)
        allow_any_instance_of(ExpenseCalc).to receive(:gross_exp).
                 and_return(1000)
        allow_any_instance_of(IncomeTax).to receive(:income_tax).
                 and_return(400)
      end
      it "returns $600 if age is less than 60" do
        expect(@non_ira.sav_spend(2019)).to eq(600)
      end
      it "returns $600 if age is >=60 and income > expenses" do
        expect(@non_ira.sav_spend(2020)).to eq(600)
      end
      it "returns -$400 if age is >=60 and expenses > income" do
        allow_any_instance_of(IncomeCalc).to receive(:gross_income).
                 and_return(2000)
        allow_any_instance_of(ExpenseCalc).to receive(:gross_exp).
                 and_return(2001)
        expect(@non_ira.sav_spend(2020)).to eq(-400)
      end
    end
  end
end
describe "non-ira_account" do
  describe "calculates the non-IRA account value in the final year" do
    context "with final age <60 and initial non-IRA value of $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2010,
          "birth_year" => 1960, 
          "ira_to_non_ira_xfer" => 0,
          "savings_interest_rate" => 0, 
          "pretax_interest_rate_reduction" => 0.0
          })
        @non_ira = NonIRA.new
        allow(@non_ira).to receive(:initial_non_ira_account_value).
             and_return(1000)
        allow(@non_ira).to receive(:sav_spend).and_return(0)
      end
      it "returns $1000 the 10th year with $0 annual spending" do
        expect(@non_ira.non_ira_account(2019)).to eq(1000)
      end
      it "returns $2000 the 10th year with $100 annual savings" do
        allow(@non_ira).to receive(:sav_spend).and_return(100)
        expect(@non_ira.non_ira_account(2019)).to eq(2000)
      end
      it "returns $1630 the 10th year with 5% interest" do
        @config_file.config["savings_interest_rate"] = 5
        expect(@non_ira.non_ira_account(2019)).to eq(1630)
      end
      it "returns $1482 the 10th year with 5% interest and .2 reduction" do
        @config_file.config["savings_interest_rate"] = 5
        @config_file.config["pretax_interest_rate_reduction"] = 0.2
        expect(@non_ira.non_ira_account(2019)).to eq(1482)
      end
    end
    context "with initial age >=60 and initial non-IRA value of $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2021,
          "birth_year" => 1960, 
          "ira_to_non_ira_xfer" => 0,
          "savings_interest_rate" => 0, 
          "pretax_interest_rate_reduction" => 0.0
          })
        @non_ira = NonIRA.new
        allow(@non_ira).to receive(:initial_non_ira_account_value).
             and_return(1000)
        allow(@non_ira).to receive(:sav_spend).and_return(0)
      end
      it "returns $1000 the 10th year with $0 annual spending" do
        expect(@non_ira.non_ira_account(2030)).to eq(1000)
      end
      it "returns $2000 the 10th year with $100 annual savings" do
        allow(@non_ira).to receive(:sav_spend).and_return(100)
        expect(@non_ira.non_ira_account(2030)).to eq(2000)
      end
      it "returns $1630 the 10th year with 5% interest" do
        @config_file.config["savings_interest_rate"] = 5
        expect(@non_ira.non_ira_account(2030)).to eq(1630)
      end
      it "returns $2000 the 10th year with $100 IRA to non-IRA xfer" do
        @config_file.config["ira_to_non_ira_xfer"] = 100
        expect(@non_ira.non_ira_account(2030)).to eq(2000)
      end
    end
    context "with initial age <60, final age >60 and initial value $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_year" => 2016,
          "birth_year" => 1960, 
          "ira_to_non_ira_xfer" => 0,
          "savings_interest_rate" => 0, 
          "ira_to_non_ira_xfer" => 100,
          "pretax_interest_rate_reduction" => 0.0
          })
        @non_ira = NonIRA.new
        allow(@non_ira).to receive(:initial_non_ira_account_value).
             and_return(1000)
        allow(@non_ira).to receive(:sav_spend).and_return(0)
      end
      it "returns $1600 the 10th year with $100 IRA to non-IRA "+
         "xfer for 6 yrs after age >60" do
        expect(@non_ira.non_ira_account(2025)).to eq(1600)
      end
    end
  end
end
describe "initial_non-ira_account_value" do
  describe "calculates the starting value of the non-IRA account" do
    context "with starting non-IRA amount of $1000" do
      before (:each) do
        @config_file = ConfigFile.new
        @config_file.set_config_override ({
          "starting_non_ira" => 1000,
          "starting_savings_discount" => 100,
          "debt_amount" => 0,
          "debt_interest" => 0,
          "debt_years" => 0 
          })
        @non_ira = NonIRA.new
      end
      it "returns $1000 with $0 debt and 100% not discounted" do
        expect(@non_ira.send(:initial_non_ira_account_value)).to eq(1000)
      end
      it "returns $800 with $0 debt and 80% not discounted" do
        @config_file.config["starting_savings_discount"] = 80
        expect(@non_ira.send(:initial_non_ira_account_value)).to eq(800)
      end
      it "returns $800 with $200 debt, 0% interest for 10 years" do
        @config_file.config["debt_amount"] = 200
        @config_file.config["debt_years"] = 10
        expect(@non_ira.send(:initial_non_ira_account_value)).to eq(800)
      end
      it "returns $700 with $200 debt, 10% interest for 10 years" do
        @config_file.config["debt_amount"] = 200
        @config_file.config["debt_years"] = 10
        @config_file.config["debt_interest"] = 10
        expect(@non_ira.send(:initial_non_ira_account_value)).to eq(700)
      end
      it "returns $765 with $200 debt, 10% interest for 3.5 years" do
        @config_file.config["debt_amount"] = 200
        @config_file.config["debt_years"] = 3.5
        @config_file.config["debt_interest"] = 10
        expect(@non_ira.send(:initial_non_ira_account_value)).to eq(765)
      end
    end
  end
end
