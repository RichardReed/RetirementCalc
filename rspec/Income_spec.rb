require_relative 'spec_helper'

describe "navy_ret_income" do
  context "with $1000 starting Navy monthly retirement in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "birth_year" => 1950,
        "navy_and_ss_raise" => 0,
        "married" => {
          "starting_navy_ret" => 1000,
          "navy_ret_start_age" => 50
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000 after 5 years with 0% raise" do
#puts "config file is: #{@config_file.config}"
      expect(@income.navy_ret_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 the first year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.navy_ret_income(2000)).to eq(12000)
      end
      it "returns $19,326 after 5 year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.navy_ret_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before navy_ret_start_age" do
      expect(@income.navy_ret_income(1999)).to eq(0)
    end
  end
end

describe "ge_pension_income" do
  context "with $1000 starting GE monthly pension in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "birth_year" => 1950,
        "ge_pension_raise" => 0,
        "married" => {
          "starting_ge_pension" => 1000,
          "ge_pension_start_age" => 50
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000 after 5 years with 0% raise" do
      expect(@income.ge_pension_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 the first year" do
        @config_file.config["ge_pension_raise"] = 10
        expect(@income.ge_pension_income(2000)).to eq(12000)
      end
      it "returns $19,326 after 5 year" do
        @config_file.config["ge_pension_raise"] = 10
        expect(@income.ge_pension_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before ge_pension_start_age" do
      expect(@income.ge_pension_income(1999)).to eq(0)
    end
  end
end

describe "alc_pension_income" do
  context "with $1000 starting Alcatel monthly pension in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "birth_year" => 1950,
        "alc_pension_raise" => 0,
        "married" => {
          "starting_alc_pension" => 1000,
          "alc_pension_start_age" => 50
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000 after 5 years with 0% raise" do
      expect(@income.alc_pension_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 the first year" do
        @config_file.config["alc_pension_raise"] = 10
        expect(@income.alc_pension_income(2000)).to eq(12000)
      end
      it "returns $19,326 after 5 year" do
        @config_file.config["alc_pension_raise"] = 10
        expect(@income.alc_pension_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before starting_year" do
      expect(@income.alc_pension_income(1999)).to eq(0)
    end
  end
end

describe "ss_income" do
  context "with $1000 starting SS monthly income in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "birth_year" => 1950,
        "ss_reduction_year" => 2020,
        "ss_reduction_percent" => 50,
        "navy_and_ss_raise" => 0,
        "married" => {
          "starting_ss" => 1000,
          "ss_start_age" => 50
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000 after 5 years with 0% raise" do
      expect(@income.ss_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 the first year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.ss_income(2000)).to eq(12000)
      end
      it "returns $19,326 after 5 year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.ss_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before starting_year" do
      expect(@income.ss_income(1999)).to eq(0)
    end
    it "returns $6,000 after 50% reduction in 2020" do
      expect(@income.ss_income(2020)).to eq (6000)
    end
  end
end

describe "ss_spouse_income" do
  context "with $1000 starting spouse's monthly SS in the year 2000" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_year" => 2000,
        "birth_year" => 1950,
        "ss_reduction_year" => 2020,
        "ss_reduction_percent" => 50,
        "navy_and_ss_raise" => 0,
        "married" => {
          "spouse_ss" => 1000,
          "spouse_ss_age" => 50,
          "spouse_new_ss" => 2000,
          "spouse_new_ss_age" => 75
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $12,000/yr after 5 years with 0% raise" do
      expect(@income.ss_spouse_income(2005)).to eq(12000)
    end
    context "with 10% raise" do
      it "returns $12,000 the first year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.ss_spouse_income(2000)).to eq(12000)
      end
      it "returns $19,326/yr after 5 year" do
        @config_file.config["navy_and_ss_raise"] = 10
        expect(@income.ss_spouse_income(2005)).to eq(19326)
      end
    end
    it "returns $0 if final_year is before starting_year" do
      expect(@income.ss_spouse_income(1999)).to eq(0)
    end
    it "returns $6,000/yr after 50% reduction the same year" do
      expect(@income.ss_spouse_income(2020)).to eq (6000)
    end
    it "returns $24,000/yr after new spouse ss of $2000/mo the same year" do
      @config_file.config["ss_reduction_year"] = 2030
      expect(@income.ss_spouse_income(2025)).to eq (24000)
    end
    it "returns $12,000/yr with new spouse ss of $2000/mo" +
        " and a 50% reduction the same year" do
      @config_file.config["married"]["spouse_new_ss_age"] = 70
      expect(@income.ss_spouse_income(2020)).to eq (12000)
    end
  end
end

describe "gross_income" do
  context "with $2000 from pension_income and $1000 lump_sum_income" do
    before (:each) do
      @income = IncomeCalc.new
      allow(@income).to receive(:total_pension_income).and_return(2000)
      allow(@income).to receive(:lump_sum_income).and_return(1000)
      allow(@income).to receive(:life_insurance_income).and_return(3000)
    end
    it "returns $3000 for the first full year" do
      expect(@income.gross_income(2000)).to eq(6000)
    end
  end
end

describe "lump_sum_income" do
  context "with $1000 lump sum income in the year 2020" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "married" => {
          "2020" => 1000,
           }
        })
      @income = IncomeCalc.new
    end
    it "returns $1000 when final_year is 2020" do
      expect(@income.lump_sum_income(2020)).to eq(1000)
    end
    it "returns $0 when final_year is 2019" do
      expect(@income.lump_sum_income(2019)).to eq(0)
    end
    it "returns $0 when final_year is 2021" do
      expect(@income.lump_sum_income(2021)).to eq(0)
    end
  end
end

describe "life_insurance_income" do
  context "with $1000 life insurance income in the year 2020" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "widowed" => {
          "life_insurance" => 1000,
          "year_widowed" => 2020 
          }
        })
      @income = IncomeCalc.new
    end
    it "returns $1000 when year is 2020" do
      expect(@income.life_insurance_income(2020)).to eq(1000)
    end
    it "returns $0 when year is 2019" do
      expect(@income.life_insurance_income(2019)).to eq(0)
    end
    it "returns $0 when year is 2021" do
      expect(@income.life_insurance_income(2021)).to eq(0)
    end
  end
end

describe "total_pension_income" do
  context "with $1000 from Navy, GE, Alcatel SS and Spouse SS" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_month" => 1,
        "starting_year" => 2000,
        })
      @income = IncomeCalc.new
      allow(@income).to receive(:navy_ret_income).and_return(1000)
      allow(@income).to receive(:ge_pension_income).and_return(1000)
      allow(@income).to receive(:alc_pension_income).and_return(1000)
      allow(@income).to receive(:ss_income).and_return(1000)
      allow(@income).to receive(:ss_spouse_income).and_return(1000)
    end
    it "returns $5000 for the first full year" do
      expect(@income.total_pension_income(2000)).to eq(5000)
    end
    it "returns $2500 for the last 6 months of the year" do
      @config_file.config["starting_month"] = 7 
      expect(@income.total_pension_income(2000)).to eq(2500)
    end
    it "returns $5000 for the 2nd year" do
      expect(@income.total_pension_income(2001)).to eq(5000)
    end
  end
end
