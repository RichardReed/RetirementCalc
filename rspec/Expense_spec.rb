require_relative 'spec_helper'

describe "initial_monthly_exp" do
  describe "adds_all_monthly_expenses except medical" do
    context "with 12 expenses of $100 each" do
      before (:each) do
        config_file = ConfigFile.new
        config_file.set_config_override ({ 
         "married" => {
           "house" => 100,
           "trailer" => 100,
           "rv_park" => 100,
           "recreation" => 100,
           "non-trailer_vac" => 100,
           "car" => 100,
           "groceries" => 100,
           "restaurant" => 100,
           "insurance" => 100,
           "invalid_expense" => 100000,
           "pres_donate" => 100,
           "rick_vicky" => 100,
           "pets" => 100,
           "medical" => 100
           }
          })
        @expenses = ExpenseCalc.new
      end

      it "returns $1200" do
        expect(@expenses.initial_monthly_exp).to eq(1200)
      end
    end
  end
end

describe "initial_annual_exp" do
  context "with $1000 for 4 annual expenses and $1200 in tot monthly exp" do
    before (:each) do
      config_file = ConfigFile.new
      config_file.set_config_override ({ 
        "married" => {
          "unexpected_exp" => 1000,
          "not_real_expense" => 1000,
          "property_tax" => 1000,
          "property_insurance" => 1000,
          "country_place_dues" => 1000
          }
        })
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:initial_monthly_exp).and_return(100)
    end
    it "returns $5200 expenses after 1 year" do
      expect(@expenses.initial_annual_exp).to eq(5200)
    end
  end
end

describe "initial_annual_med_exp" do
  context "with $100 in medical expenses each month" do
    before (:each) do
      config_file = ConfigFile.new
      config_file.set_config_override ({
        "married" => {
          "medical" => 100,
          "rick_vicky" => 100
          }
        })
      @expenses = ExpenseCalc.new
    end
    it "returns $1200" do
      expect(@expenses.initial_annual_med_exp).to eq(1200)
    end
  end
end

describe "annual_exp" do
  context "with $1000 initial annual expenses" do
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
      allow(@expenses).to receive(:initial_annual_exp).and_return(1000)
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
  context "with widowed year of 2025," do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({ 
        "married" => {
          "2020" => -1000, 
          "2015" => 2000, 
          "2030" => -7000,
          "2035" => 8000
        },
        "widowed" => {
          "widowed_year" => 2025,
          "2020" => -3000,
          "2015" => 4000,
          "2030" => -5000,
          "2035" => 6000
        }
      })
      @expenses = ExpenseCalc.new
    end
    it "it returns $1000 for the large married expense in the year 2020" + 
       " and $0 for the years 2019 and 2021." do
      expect(@expenses.large_exp(2019)).to eq(0)
      expect(@expenses.large_exp(2020)).to eq(1000)
      expect(@expenses.large_exp(2021)).to eq(0)
    end
    it "returns $0 for 2015 when there is a large married income." do
      expect(@expenses.large_exp(2015)).to eq(0)
    end
    it "returns $5000 for the large widowed expense in the year 2030" +
       " and $0 for the years 2029 and 2031." do
      expect(@expenses.large_exp(2029)).to eq(0)
      expect(@expenses.large_exp(2030)).to eq(5000)
      expect(@expenses.large_exp(2031)).to eq(0)
    end
    it "returns $0 for 2035 when there is a large widowed income." do
      expect(@expenses.large_exp(2035)).to eq(0)
    end
  end
end

describe "annual_med_exp" do
  context "with $1000 initial annual medical expenses" do
    before (:each) do
      @config_file = ConfigFile.new
      @config_file.set_config_override ({
        "starting_year" => 2020,
        "starting_month" => 1,
        "med_exp_inflation" => 0
      })
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:initial_annual_med_exp).and_return(1000)
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
      @config_file = ConfigFile.new
        @config_file.set_config_override ({
           "widowed" => {
             "widowed_year" => 2025
           }
        })
      @expenses = ExpenseCalc.new
        allow(@expenses).to receive(:annual_exp).and_return(1000)
        allow(@expenses).to receive(:annual_med_exp).and_return(1000)
        allow(@expenses).to receive(:large_exp).and_return(1000)
        allow(@expenses).to receive(:widowed_expense_fract).and_return(0.5)
    end
    it "returns $3000 for the first full year" do
      expect(@expenses.gross_exp(2020)).to eq(3000)
    end
    it "returns widowed expense of $2000" do
      expect(@expenses.gross_exp(2025)).to eq(2000)
    end
  end
end

describe "claculate widowed expense fraction" do
  context "with values for initial widowed and initial maried expense" do
    before (:each) do
      @expenses = ExpenseCalc.new
      allow(@expenses).to receive(:initial_annual_exp)
            .and_return(2800)
      allow(@expenses).to receive(:initial_annual_med_exp)
            .and_return(1200)
      allow_any_instance_of(WidowedExpense)
            .to receive(:initial_widowed_annual_exp).and_return(2000)
    end
    it "returns widowed expense fraction of 0.5" do
      expect(@expenses.widowed_expense_fract).to eq(0.5)
    end
  end
end
