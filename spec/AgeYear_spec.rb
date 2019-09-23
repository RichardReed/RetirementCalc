require_relative 'spec_helper'

module AgeYear
  describe "is_age," do
    describe "converts birth_year to age," do
      context "with birth year of 1960," do
        before (:each) do
          config_file = ConfigFile.new
          config_file.set_config_override ({ "birth_year" => 1960 })
          config_file.config
        end
        it "returns age 5 in 1965" do
          expect(1965.is_age).to eq(5)
        end
        it "returns age 60 in 2020" do
          expect(2020.is_age).to eq(60)
        end
      end
      context "with birth year 2010" do
        before (:each) do
          config_file = ConfigFile.new
          config_file.set_config_override ({ "birth_year" => 2010 })
          config_file.config
        end
        it "returns age 8 in 2018" do
          expect(2018.is_age).to eq(8)
        end
        it "returns age 65 in 2075" do
          expect(2075.is_age).to eq(65)
        end
      end
    end
  end
  describe "is_year" do
    describe "converts age to birth_year" do
      context "with birth year 1960," do
        before (:each) do
          config_file = ConfigFile.new
          config_file.set_config_override ({ "birth_year" => 1960 })
          config_file.config
        end
        it "returns 1970 for age 10" do
          expect(10.is_year).to eq(1970)
        end
        it "returns 2069 for age 109" do
          expect(109.is_year).to eq(2069)
        end
      end
       context "with birth year 1999," do
         before (:each) do
           config_file = ConfigFile.new
           config_file.set_config_override ({ "birth_year" => 1999 })
           config_file.config
         end
         it "returns 1999 for age 0" do
           expect(0.is_year).to eq(1999)
         end
         it "returns 2069 for age 70" do
           expect(70.is_year).to eq(2069)
         end
       end

    end
  end
end
