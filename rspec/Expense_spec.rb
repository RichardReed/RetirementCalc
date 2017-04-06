require_relative 'spec_helper'

describe "starting_monthly_exp" do
  describe "adds_all_monthly_expenses except medical" do
    context "with 12 expenses of $100 each" do
      before (:each) do
        config_file = ConfigFile.new
        config_file.set_config_override ({ 
          "house_exp" => 100, 
          "trailer_exp" => 100,
          "rv_park" => 100,
          "rec_exp" => 100,
          "non-trailer_vac" => 100,
          "car" => 100,
          "groceries" => 100,    
          "restaurant" => 100,
          "insurance" => 100,
          "pres_donate"=> 100,
          "rick_vicky" => 100,
          "medical" => 100,
          "pets" => 100,
          })
        @expenses = ExpenseCalc.new
      end

      it "returns $1200" do
        expect(@expenses.starting_monthly_exp).to eq(1200)
      end
    end
  end
end

describe "starting_annual_exp" do
  context "with $1000 for 4 annual expenses and $1200 in tot monthly exp" do
    before (:each) do
      config_file = ConfigFile.new
      config_file.set_config_override ({ 
        "large_annual_exp" => 1000,
        "travel_exp" => 1000,
        "property_tax" => 1000,
        "medical_exp" => 1000,
        "property_insurance" => 1000,
        "country_place_dues" => 1000
        })
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:starting_monthly_exp).and_return(100)
    end
    it "returns $5200 expenses after 1 year" do
      expect(@expenses.starting_annual_exp).to eq(5200)
    end
  end
end

describe "starting_annual_med_exp" do
  context "with $100 in medical expenses each month" do
    before (:each) do
      config_file = ConfigFile.new
      config_file.set_config_override ({
        "medical_exp" => 100
        })
      @expenses = ExpenseCalc.new
    end
    it "returns $1200" do
      expect(@expenses.starting_annual_med_exp).to eq(1200)
    end
  end
end

describe "annual_exp" do
  context "with $1000 starting annual expenses" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_year" => 2020,
        "starting_month" => 1,
        "expense_inflation" => 0,
        "reduce_prop_tax_age" => 100,
        "property_tax_reduction" => 0,
        "birth_year" => 2000
      })
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:starting_annual_exp).and_return(1000)
    end
    it "returns $1000 after 1 year" do
      expect(@expenses.annual_exp(2020)).to eq(1000)
    end
    context "with no inflation" do
      it "returns $1000 after 12 years" do
        expect(@expenses.annual_exp(2032)).to eq(1000)
      end
    end
    context "with first year starting in month 7" do
      it "returns $500 for the second half of the year" do
        @config_file.config["starting_month"] = 7 
        expect(@expenses.annual_exp(2020)).to eq(500)
      end
      it "returns $1000 for the second year" do
        @config_file.config["starting_month"] = 7 
        expect(@expenses.annual_exp(2021)).to eq(1000)
      end
    end
    context "with first year starting in month 12" do
      it "returns $83.33 for one month" do
        @config_file.config["starting_month"] = 12
        expect(@expenses.annual_exp(2020)).to eq(1000/12.0)
      end
    end
    context "with 10% inflation" do
      it "returns $1000 after 1 year" do
        @config_file.config["expense_inflation"] = 10
        expect(@expenses.annual_exp(2020)).to eq(1000)
      end
      it "returns $1100 after 2 years" do
        @config_file.config["expense_inflation"] = 10
        expect(@expenses.annual_exp(2021)).to eq(1100)
      end
    end
    context "with $100 reduction in property tax at age 60" do
      it "returns $1000 at age 59 and $900 at age 60" do
        @config_file.config["reduce_prop_tax_age"] = 60
        @config_file.config["property_tax_reduction"] = 100
        expect(@expenses.annual_exp(2060)).to eq(900)
        expect(@expenses.annual_exp(2059)).to eq(1000)
      end
    end
  end
end

describe "large_exp" do
  context "with $1000 large expense for 2020" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({ "2020" => -1000 })
      @expenses = ExpenseCalc.new
    end
    it "returns $1000 for year 2020, and $0 for 2019 and 2021" do
      expect(@expenses.large_exp(2019)).to eq(0)
      expect(@expenses.large_exp(2020)).to eq(1000)
      expect(@expenses.large_exp(2021)).to eq(0)
    end
  end
end

describe "annual_med_exp" do
  context "with $1000 starting annual medical expenses" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_year" => 2020,
        "starting_month" => 1,
        "med_exp_inflation" => 0,
      })
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:starting_annual_med_exp).and_return(1000)
    end
    it "returns $1000 after 1 year" do
      expect(@expenses.annual_med_exp(2020)).to eq(1000)
    end
    context "with no inflation" do
      it "returns $1000 after 12 years" do
        expect(@expenses.annual_med_exp(2032)).to eq(1000)
      end
    end
    context "with first year starting in month 7" do
      it "returns $500 for the second half of the year" do
        @config_file.config["starting_month"] = 7 
        expect(@expenses.annual_med_exp(2020)).to eq(500)
      end
      it "returns $1000 for the second year" do
        @config_file.config["starting_month"] = 7 
        expect(@expenses.annual_med_exp(2021)).to eq(1000)
      end
    end
    context "with first year starting in month 12" do
      it "returns $83.33 for one month" do
        @config_file.config["starting_month"] = 12
        expect(@expenses.annual_med_exp(2020)).to eq(1000/12.0)
      end
    end
    context "with 10% medical expense inflation" do
      it "returns $1000 after 1 year" do
        @config_file.config["med_exp_inflation"] = 10
        expect(@expenses.annual_med_exp(2020)).to eq(1000)
      end
      it "returns $1100 after 2 years" do
        @config_file.config["med_exp_inflation"] = 10
        expect(@expenses.annual_med_exp(2021)).to eq(1100)
      end
    end
  end
end

describe "gross_exp" do
  context "with $1000 in each of annual expenses, 
  annual medical expenses and large expenses" do
    before (:each) do
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:annual_exp).and_return(1000)
      allow(@expenses).to receive(:annual_med_exp).and_return(1000)
      allow(@expenses).to receive(:large_exp).and_return(1000)
    end
    it "returns $3000" do
      expect(@expenses.gross_exp(2020)).to eq(3000)
    end
  end
end
