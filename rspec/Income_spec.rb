require_relative 'spec_helper'

describe "navy_ret_income" do
  context "with $1000 starting Navy retirement in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_navy_ret" => 1000,
        "starting_year" => 2000,
        "navy_and_ss_raise" => 0
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000 after 5 years with 0% raise" do
      expect(@income.navy_ret_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 after 0 years" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.navy_ret_income(2000)).to eq(12000)
      end
      it "returns $19,326 after 5 year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.navy_ret_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before starting_year" do
      expect(@income.navy_ret_income(1999)).to eq(0)
    end
  end
end
